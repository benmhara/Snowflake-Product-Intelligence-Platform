{{ config(materialized='table') }}

SELECT

    p.product_id,
    p.product_name,
    p.category,
    r.review_id,
    r.review_title,
    r.review_content,
    rm.review_length,
    rm.review_quality,

    p.actual_price,
    p.discounted_price,

    p.discount_amount,

    p.rating,
    p.rating_count,

    p.popularity_score,
    p.value_score,

    ROUND(
        (p.popularity_score * 0.5)
        + (p.value_score * 0.3)
        + (p.rating * 20 * 0.2),
        2
    ) AS opportunity_score,

    ROUND(
        (p.rating * 20 * 0.6)
        + (LEAST(p.rating_count, 1000) / 10 * 0.4),
        2
    ) AS product_health_score,

    CASE
        WHEN p.value_score > 50
        THEN 'High Opportunity'

        WHEN p.value_score > 20
        THEN 'Medium Opportunity'

        ELSE 'Low Opportunity'
    END AS market_opportunity

FROM {{ ref('int_product_metrics') }} p
LEFT JOIN {{ ref('stg_reviews') }} r
    ON p.product_id = r.product_id
LEFT JOIN {{ ref('int_review_metrics') }} rm
    ON r.review_id = rm.review_id
