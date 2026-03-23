# infra

로컬 AI/ML 개발 환경을 위한 Docker Compose 인프라 스택입니다.

## 서비스 구성

| 서비스 | 이미지 | 포트 | 용도 |
|--------|--------|------|------|
| MySQL | mysql:8.4 | 3306 | 관계형 DB |
| PostgreSQL | pgvector/pgvector:pg17 | 5432 | 관계형 DB + 벡터 검색 |
| Qdrant | qdrant/qdrant:v1.13.1 | 6333 / 6334 | 벡터 DB |
| TEI | huggingface/text-embeddings-inference:cpu-1.8 | 8080 | 텍스트 임베딩 서버 |
| Ollama | ollama/ollama:0.6.2 | 11434 | LLM 서버 |
| vLLM | vllm/vllm-openai:v0.7.3 | 8000 | LLM 서버 (OpenAI 호환) |

## 시작하기

### 1. 환경 변수 설정

```bash
cp db/mysql/.env.example db/mysql/.env
cp db/postgres/.env.example db/postgres/.env
cp embed/.env.example embed/.env
cp vllm/.env.example vllm/.env
```

각 `.env` 파일을 열어 값을 수정합니다.

### 2. 서비스 실행

```bash
# DB 개별 실행
make up-mysql
make up-postgres
make up-qdrant

# DB 전체
make up-db

# 임베딩
make up-embed

# LLM
make up-ollama
make up-vllm

# 전체
make up-all
```

### 3. 서비스 종료

```bash
# 개별 종료
make down-mysql
make down-postgres
make down-qdrant
make down-embed
make down-ollama
make down-vllm

# 전체 종료
make down-all
```

### 4. 상태 확인

```bash
make ps
```

## 디렉토리 구조

```
infra/
├── db/
│   ├── mysql/
│   │   ├── compose.mysql.yaml
│   │   └── .env.example
│   ├── postgres/
│   │   ├── compose.postgres.yaml
│   │   └── .env.example
│   └── qdrant/
│       └── compose.qdrant.yaml
├── embed/
│   ├── compose.tei.yaml
│   ├── Dockerfile.tei
│   └── .env.example
├── ollama/
│   └── compose.ollama.yaml
├── vllm/
│   ├── compose.vllm.yaml
│   └── .env.example
├── Makefile
└── .gitignore
```

## 주의사항

- `.env` 파일은 절대 커밋하지 않습니다 (`.gitignore`에 포함됨)
- 모델 파일 및 DB 데이터 디렉토리는 자동으로 gitignore 처리됩니다
- 이미지 버전을 변경할 경우 compose 파일의 `image` 태그를 직접 수정합니다
