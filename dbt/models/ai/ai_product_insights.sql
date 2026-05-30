{{ config(materialized='table') }}

SELECT
    m.product_id,
    m.product_name,
    m.category,
    m.rating,
    m.rating_count,
    m.opportunity_score,
    m.product_health_score,
    s.sentiment_score,
    CASE
        WHEN s.sentiment_score > 0.3 THEN 'Positive'
        WHEN s.sentiment_score < -0.3 THEN 'Negative'
        ELSE 'Neutral'
    END AS sentiment_label,
    CASE
        WHEN m.rating >= 4.5
             AND s.sentiment_score < 0
        THEN 'Suspicious Product'
        WHEN m.rating >= 4.3
             AND m.rating_count < 100
        THEN 'Hidden Gem'
        WHEN s.sentiment_score < -0.5
        THEN 'Customer Risk'
        ELSE 'Normal'
    END AS ai_business_flag

FROM {{ ref('mart_business_ready_products') }} m
LEFT JOIN {{ ref('ai_sentiment') }} s
    ON m.review_id = s.review_id
