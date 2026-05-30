{{ config(materialized='table') }}

SELECT
    product_id,
    review_id,
    product_name,
    category,
    CONCAT(
        'Product: ', product_name,
        '\nCategory: ', category,
        '\nRating: ', rating,
        '\nReview: ', review_content
    ) AS rag_context,
    review_embedding

FROM {{ ref('ai_review_embeddings') }}
WHERE review_content IS NOT NULL
