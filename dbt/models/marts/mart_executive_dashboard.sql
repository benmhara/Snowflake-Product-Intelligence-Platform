{{ config(materialized='table') }}

SELECT
    COUNT(DISTINCT product_id) AS total_products,
    COUNT(DISTINCT category) AS total_categories,
    ROUND(AVG(rating), 2) AS average_rating,
    SUM(rating_count) AS total_rating_count,
    ROUND(AVG(opportunity_score), 2) AS average_opportunity_score,
    COUNT_IF(market_opportunity = 'High Opportunity') AS high_opportunity_products

FROM {{ ref('mart_business_ready_products') }}
