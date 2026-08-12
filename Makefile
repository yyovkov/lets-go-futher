include .envrc

# ==============================================================================
# ==============================================================================
# HELERS
# ==============================================================================
## help: print this help message
.PHONY: help
help:
	@echo 'Usage:'
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' | sed -e 's/^/ /'

confirm:
	@echo -n 'Are you sure? [y/N]' && read ans && [ $${ans:-N} = y ]

# ==============================================================================
# TARGETS
# ==============================================================================
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
