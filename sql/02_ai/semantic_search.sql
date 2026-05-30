USE DATABASE amazon_product_intelligence;
USE SCHEMA ai;

CREATE OR REPLACE VIEW ai_semantic_search AS
WITH similarities AS (
    SELECT

        a.product_name AS source_product,
        b.product_name AS similar_product,

        VECTOR_COSINE_SIMILARITY(
            a.review_embedding,
            b.review_embedding
        ) AS similarity_score

    FROM ai_review_embeddings a
    JOIN ai_review_embeddings b
        ON a.product_id != b.product_id
)

SELECT *
FROM similarities
WHERE similarity_score > 0.85;
