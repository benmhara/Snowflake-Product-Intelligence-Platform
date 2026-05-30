# Amazon Product Intelligence Platform

Enterprise-style product intelligence platform built on Snowflake, dbt, Cortex AI, semantic search, and Streamlit.

## Platform Architecture

Raw Amazon product data flows through Snowflake ingestion into Bronze tables. dbt owns all reusable transformation logic through staging, intermediate, mart, and AI-ready models. Cortex AI enriches reviews with sentiment and embeddings. Streamlit and the FastAPI service expose product rankings, semantic search, recommendations, and executive insights.

```text
Raw Data
  -> Snowflake Ingestion
  -> Bronze Tables
  -> dbt Staging Models
  -> dbt Intermediate Models
  -> dbt Mart Models
  -> Cortex AI Enrichment
  -> Embeddings + Semantic Search
  -> RAG Retrieval
  -> Streamlit / API Interfaces
```

## Repository Layout

```text
docs/                 Architecture, setup, data dictionary, and use cases
data/                 Raw and sample data
sql/                  Snowflake setup, ingestion, AI operations, automation, security, observability
dbt/                  Transformation, mart, and AI-ready model project
streamlit/            Product intelligence app
api/                  FastAPI service for product and semantic endpoints
notebooks/            Exploration and experimentation
infrastructure/       Terraform-ready infrastructure area
tests/                Data quality, dbt, and Streamlit tests
```

## dbt Layers

| Layer | Purpose | Materialization |
| --- | --- | --- |
| staging | lightweight cleaning, casting, deduplication | view |
| intermediate | reusable metrics and scoring logic | table |
| marts | business-ready analytics datasets | table |
| ai | sentiment, embeddings, RAG context, recommendations | table |

## Run Order

1. Execute SQL setup scripts in `sql/00_setup`.
2. Load source data with `sql/01_ingestion`.
3. Run dbt from the `dbt/` directory.
4. Build or refresh AI operations in `sql/02_ai` if using SQL-managed AI objects.
5. Launch Streamlit from `streamlit/Home.py` or FastAPI from `api/app/main.py`.
