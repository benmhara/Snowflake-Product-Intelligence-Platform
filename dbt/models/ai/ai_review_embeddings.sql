{{ config(materialized='table') }}

SELECT
    product_id,
    review_id,
    product_name,
    category,
    rating,
    review_content,
    AI_EMBED(
        'snowflake-arctic-embed-m',
        review_content
    ) AS review_embedding,
    CURRENT_TIMESTAMP() AS embedding_created_at

FROM {{ ref('mart_business_ready_products') }}
WHERE review_content IS NOT NULL
