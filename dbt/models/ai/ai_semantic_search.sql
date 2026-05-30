{{ config(materialized='table') }}

WITH similarities AS (
    SELECT
        a.product_id AS source_product_id,
        a.product_name AS source_product_name,
        b.product_id AS similar_product_id,
        b.product_name AS similar_product_name,
        VECTOR_COSINE_SIMILARITY(
            a.review_embedding,
            b.review_embedding
        ) AS similarity_score

    FROM {{ ref('ai_review_embeddings') }} a
    JOIN {{ ref('ai_review_embeddings') }} b
        ON a.product_id != b.product_id
)

SELECT *
FROM similarities
WHERE similarity_score > 0.85
