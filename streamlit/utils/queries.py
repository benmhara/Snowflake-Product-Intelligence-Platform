import os

import pandas as pd
import snowflake.connector
from dotenv import load_dotenv

load_dotenv()


def get_connection():
    return snowflake.connector.connect(
        account=os.getenv("SNOWFLAKE_ACCOUNT"),
        user=os.getenv("SNOWFLAKE_USER"),
        password=os.getenv("SNOWFLAKE_PASSWORD"),
        warehouse=os.getenv("SNOWFLAKE_WAREHOUSE"),
        database=os.getenv("SNOWFLAKE_DATABASE"),
        schema=os.getenv("SNOWFLAKE_SCHEMA"),
        role=os.getenv("SNOWFLAKE_ROLE"),
    )


def run_query(sql: str, params=None) -> pd.DataFrame:
    conn = get_connection()
    try:
        return pd.read_sql(sql, conn, params=params)
    finally:
        conn.close()


def top_products(limit: int = 25) -> pd.DataFrame:
    return run_query(
        """
        SELECT product_name, category, rating, rating_count, popularity_score
        FROM analytics.mart_business_ready_products
        QUALIFY ROW_NUMBER() OVER (
            PARTITION BY product_id
            ORDER BY popularity_score DESC
        ) = 1
        ORDER BY popularity_score DESC
        LIMIT %(limit)s
        """,
        {"limit": limit},
    )


def recommendations(limit: int = 25) -> pd.DataFrame:
    return run_query(
        """
        SELECT product_name, category, rating, recommendation_score
        FROM ai.ai_recommendations
        ORDER BY recommendation_score DESC
        LIMIT %(limit)s
        """,
        {"limit": limit},
    )


def executive_metrics() -> pd.DataFrame:
    return run_query("SELECT * FROM analytics.mart_executive_dashboard")


def semantic_search(query: str, limit: int = 10) -> pd.DataFrame:
    return run_query(
        """
        WITH query_embedding AS (
            SELECT AI_EMBED('snowflake-arctic-embed-m', %(query)s) AS embedding
        )
        SELECT
            product_name,
            category,
            review_content,
            VECTOR_COSINE_SIMILARITY(review_embedding, query_embedding.embedding)
                AS similarity_score
        FROM ai.ai_review_embeddings, query_embedding
        ORDER BY similarity_score DESC
        LIMIT %(limit)s
        """,
        {"query": query, "limit": limit},
    )
