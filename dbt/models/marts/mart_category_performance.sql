{{ config(materialized='table') }}

SELECT
    category,
    COUNT(DISTINCT product_id) AS product_count,
    ROUND(AVG(rating), 2) AS average_rating,
    SUM(rating_count) AS total_rating_count,
    ROUND(AVG(discount_amount), 2) AS average_discount_amount,
    ROUND(AVG(popularity_score), 2) AS average_popularity_score,
    ROUND(AVG(value_score), 2) AS average_value_score

FROM {{ ref('mart_business_ready_products') }}
GROUP BY category
