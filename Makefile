include .envrc

# ============================================================================ #
# HELERS
# ============================================================================ #

## help: print this help message
.PHONY: help
help:
	@echo 'Usage:'
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' | sed -e 's/^/ /'

confirm:
	@echo -n 'Are you sure? [y/N]' && read ans && [ $${ans:-N} = y ]

# ============================================================================ #
# DEVELOPMENT
# ============================================================================ #
#
## start: Start start focker compose
.PHONY: start
start:
	docker compose up -d

## stop: Stop docker compose
.PHONY: stop
stop:
	docker compose down

## run/api: run the cmd/api application
.PHONY: run/api
run/api:
	go run ./cmd/api -db-dsn=${GREENLIGHT_DB_DSN}

## db/psql: connect to database using psql
.PHONY: db/psql
db/psql:
	psql ${GREENLIGHT_DB_DSN}

## db/migrations/new name:$1: create a new database migration
.PHONY: db/migrations/new 
db/migrations/new:
	migrate create -seq -ext=.sql -dir=./migrations ${name}

## db/migrations/up: apply all up database migrations
.PHONY: db/migrations/us
db/migrations/up: confirm
	migrate -path ./migrations -database ${GREENLIGHT_DB_DSN} up

# ============================================================================ #
# QUALITY CONTROL
# ============================================================================ #

## tidy: tidy module dependencies, and format and modernize all .go files
.PHONY: tidy
tidy:
	go mod tidy
	go mod verify
	go mod vendor
	go fix ./...
	go fmt ./...

## audit: run quality control check
.PHONY: audit
audit:
	go mod tidy -diff
	go mod verify
	go vet ./...
	go tool staticcheck ./...
	go test -race -vet=off ./...

# ============================================================================ #
# BUILD
# ============================================================================ #

## build/api: build the cmd/api application
.PHONY: build/api
build/api:
	go build -ldflags='-s' -o=./bin/api ./cmd/api
	GOOS=linux GOARCH=amd64 go build -ldflags='-s' -o=./bin/linux_amd64/api ./cmd/api

# ============================================================================ #
# PRODUCTION
# ============================================================================ #

production_host = 'greenlight.castle.yyovkov.net'
prduction_deployment_user = 'yyovkov'

## production/connect: connect to the production server
.PHONY: production/connect
production/connect:
	ssh ${prduction_deployment_user}@${production_host}

## production/deploy/api
.PHONY: production/deploy/api
production/deploy/api:
	rsync -P ./bin/linux_amd64/api ${prduction_deployment_user}@${production_host}:~
	rsync -rP --delete ./migrations ${prduction_deployment_user}@${production_host}:~
	rsync -P ./remote/production/api.service ${prduction_deployment_user}@${production_host}:~
	rsync -P ./remote/production/Caddyfile ${prduction_deployment_user}@${production_host}:~
	ssh -t ${prduction_deployment_user}@${production_host} '\
		migrate -path ~/migrations -database $${GREENLIGHT_DB_DSN} up \
		&& sudo mv ~/api.service /etc/systemd/system/ \
		&& sudo systemctl daemon-reload \
		&& sudo systemctl enable api \
		&& sudo systemctl restart api \
		&& sudo mv ~/Caddyfile /etc/caddy/ \
		&& sudo systemctl reload caddy \
		'

