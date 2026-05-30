{{ config(materialized='table') }}

SELECT
    product_id,
    product_name,
    category,
    rating,
    opportunity_score,
    product_health_score,
    sentiment_score,
    ROUND(
        (product_health_score * 0.4)
        + (opportunity_score * 0.3)
        + (COALESCE(sentiment_score, 0) * 10 * 0.3),
        2
    ) AS recommendation_score

FROM {{ ref('ai_product_insights') }}
QUALIFY ROW_NUMBER() OVER (
    PARTITION BY product_id
    ORDER BY recommendation_score DESC
) = 1
