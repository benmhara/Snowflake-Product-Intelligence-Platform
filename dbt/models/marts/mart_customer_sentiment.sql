{{ config(materialized='table') }}

SELECT
    m.product_id,
    m.product_name,
    m.category,
    ROUND(AVG(s.sentiment_score), 3) AS average_sentiment_score,
    COUNT(*) AS review_count,
    COUNT_IF(s.sentiment_score > 0.3) AS positive_reviews,
    COUNT_IF(s.sentiment_score < -0.3) AS negative_reviews

FROM {{ ref('mart_business_ready_products') }} m
LEFT JOIN {{ ref('ai_sentiment') }} s
    ON m.review_id = s.review_id
GROUP BY
    m.product_id,
    m.product_name,
    m.category
