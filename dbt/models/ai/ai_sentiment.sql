{{ config(materialized='table') }}

SELECT

    review_id,
    product_id,

    review_content,

    SNOWFLAKE.CORTEX.SENTIMENT(review_content)
    AS sentiment_score

FROM {{ ref('stg_reviews') }}
WHERE review_content IS NOT NULL
