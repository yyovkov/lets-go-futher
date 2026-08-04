# ==============================================================================
# HELERS
# ==============================================================================

## help: print this help message
.PHONY: help
help:
	@echo 'Usage:'
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' | sed -e 's/^/ /'

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
