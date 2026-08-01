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
## db-start: Start postgreslq database
.PHONY: start
start:
	docker compose up -d


.PHONY: stop
stop:
	docker compose down
