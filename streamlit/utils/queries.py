import pandas as pd
from snowflake.snowpark.context import get_active_session


def get_session():
    return get_active_session()


def run_query(sql: str, params=None) -> pd.DataFrame:
    session = get_session()
    return session.sql(sql, params=params).to_pandas()


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
        LIMIT ?
        """,
        [limit],
    )


def recommendations(limit: int = 25) -> pd.DataFrame:
    return run_query(
        """
        SELECT product_name, category, rating, recommendation_score
        FROM ai.ai_recommendations
        ORDER BY recommendation_score DESC
        LIMIT ?
        """,
        [limit],
    )


def executive_metrics() -> pd.DataFrame:
    return run_query("SELECT * FROM analytics.mart_executive_dashboard")


def semantic_search(query: str, limit: int = 10) -> pd.DataFrame:
    return run_query(
        """
        WITH query_embedding AS (
            SELECT AI_EMBED('snowflake-arctic-embed-m', ?) AS embedding
        )
        SELECT
            product_name,
            category,
            review_content,
            VECTOR_COSINE_SIMILARITY(review_embedding, query_embedding.embedding)
                AS similarity_score
        FROM ai.ai_review_embeddings, query_embedding
        ORDER BY similarity_score DESC
        LIMIT ?
        """,
        [query, limit],
    )
