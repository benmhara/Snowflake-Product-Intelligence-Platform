# Platform Architecture

The platform separates operational Snowflake concerns from transformation logic and user-facing experiences.

## Flow

```text
Raw Data
  -> Snowflake Ingestion Layer
  -> Bronze Tables
  -> dbt Staging Models
  -> dbt Intermediate Models
  -> dbt Mart Models
  -> Cortex AI Enrichment
  -> Embeddings + Semantic Search
  -> RAG Retrieval
  -> Streamlit AI Interface
```

## Ownership Boundaries

| Area | Responsibility |
| --- | --- |
| `sql/00_setup` | database, schemas, roles, warehouse, Cortex readiness |
| `sql/01_ingestion` | file formats, stages, raw tables, validation |
| `dbt/models/staging` | standardization without business logic |
| `dbt/models/intermediate` | reusable product and review calculations |
| `dbt/models/marts` | analytics-ready business datasets |
| `dbt/models/ai` | AI-native datasets for sentiment, search, RAG, and recommendations |
| `sql/03_automation` | Dynamic Tables, streams, tasks, incremental orchestration |
| `sql/04_security` | grants, masking, row access, audit queries |
| `sql/05_observability` | query, cost, warehouse, and AI usage monitoring |
| `streamlit/` | interactive user experience |
| `api/` | API access to product intelligence services |
