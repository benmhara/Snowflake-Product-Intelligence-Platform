from app.database import get_connection

from app.core.logging_config import logger

from app.core.exceptions import (
    SemanticSearchError
)


def search_semantic_products(
    query: str,
    limit: int = 10
):

    try:

        logger.info(
            f"Starting semantic search for query: {query}"
        )

        conn = get_connection()

        cursor = conn.cursor()

        sql = """
        WITH query_embedding AS (

            SELECT
                AI_EMBED(
                    'snowflake-arctic-embed-m',
                    %s
                ) AS embedding
        )

        SELECT

            product_name,
            category,
            review_content,

            VECTOR_COSINE_SIMILARITY(
                review_embedding,
                query_embedding.embedding
            ) AS similarity_score

        FROM AI.AI_REVIEW_EMBEDDINGS,
             query_embedding

        ORDER BY similarity_score DESC

        LIMIT %s
        """

        cursor.execute(sql, (query, limit))

        rows = cursor.fetchall()

        results = []

        for row in rows:

            results.append({
                "product_name": row[0],
                "category": row[1],
                "review_content": row[2],
                "similarity_score": row[3]
            })

        logger.info(
            f"Semantic search returned "
            f"{len(results)} results"
        )

        cursor.close()
        conn.close()

        return results

    except Exception as e:

        logger.error(
            f"Semantic search failed: {str(e)}"
        )

        raise SemanticSearchError(
            detail=str(e)
        )
