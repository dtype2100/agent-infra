COMPOSE := docker compose

# ─── DB: 개별 ────────────────────────────────────────────────
up-mysql:
	$(COMPOSE) -f db/mysql/compose.mysql.yaml --env-file db/mysql/.env up -d

down-mysql:
	$(COMPOSE) -f db/mysql/compose.mysql.yaml down

up-postgres:
	$(COMPOSE) -f db/postgres/compose.postgres.yaml --env-file db/postgres/.env up -d

down-postgres:
	$(COMPOSE) -f db/postgres/compose.postgres.yaml down

up-qdrant:
	$(COMPOSE) -f db/qdrant/compose.qdrant.yaml up -d

down-qdrant:
	$(COMPOSE) -f db/qdrant/compose.qdrant.yaml down

# ─── DB: 전체 ────────────────────────────────────────────────
up-db: up-mysql up-postgres up-qdrant

down-db: down-mysql down-postgres down-qdrant

# ─── Embed ───────────────────────────────────────────────────
up-embed:
	$(COMPOSE) -f embed/compose.tei.yaml --env-file embed/.env up -d

down-embed:
	$(COMPOSE) -f embed/compose.tei.yaml down

# ─── Ollama ──────────────────────────────────────────────────
up-ollama:
	$(COMPOSE) -f ollama/compose.ollama.yaml up -d

down-ollama:
	$(COMPOSE) -f ollama/compose.ollama.yaml down

# ─── vLLM ────────────────────────────────────────────────────
up-vllm:
	$(COMPOSE) -f vllm/compose.vllm.yaml --env-file vllm/.env up -d

down-vllm:
	$(COMPOSE) -f vllm/compose.vllm.yaml down

# ─── 전체 ────────────────────────────────────────────────────
up-all: up-db up-embed up-ollama up-vllm

down-all: down-db down-embed down-ollama down-vllm

# ─── 상태 확인 ───────────────────────────────────────────────
ps:
	@echo "=== MySQL ===" && $(COMPOSE) -f db/mysql/compose.mysql.yaml ps
	@echo "=== PostgreSQL ===" && $(COMPOSE) -f db/postgres/compose.postgres.yaml ps
	@echo "=== Qdrant ===" && $(COMPOSE) -f db/qdrant/compose.qdrant.yaml ps
	@echo "=== TEI ===" && $(COMPOSE) -f embed/compose.tei.yaml ps
	@echo "=== Ollama ===" && $(COMPOSE) -f ollama/compose.ollama.yaml ps
	@echo "=== vLLM ===" && $(COMPOSE) -f vllm/compose.vllm.yaml ps

.PHONY: up-mysql down-mysql up-postgres down-postgres up-qdrant down-qdrant \
        up-db down-db up-embed down-embed up-ollama down-ollama \
        up-vllm down-vllm up-all down-all ps
