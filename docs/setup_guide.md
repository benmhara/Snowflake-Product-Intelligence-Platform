# Setup Guide

## 1. Configure Environment

Copy `.env.example` to `.env` and fill in the Snowflake connection values.

## 2. Create Snowflake Objects

Run scripts in:

```text
sql/00_setup
sql/01_ingestion
```

## 3. Run dbt

From the `dbt/` directory, install packages and run the project:

```text
dbt deps
dbt build
```

## 4. Launch Interfaces

FastAPI:

```text
uvicorn app.main:app --reload
```

Streamlit:

```text
streamlit run streamlit/Home.py
```
