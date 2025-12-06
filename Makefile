.PHONY: up
up:
	docker compose up

.PHONY: migrate
migrate:
	uv run myapp manage migrate

.PHONY: dev
dev: migrate
	uv run python scripts/setup_dev.py

.PHONY: run
run:
	uv run myapp manage runserver_plus
