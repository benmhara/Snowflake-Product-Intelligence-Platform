{{ config(materialized='table') }}

SELECT
    product_id,
    product_name,
    category,
    rating,
    rating_count,
    value_score,
    opportunity_score,
    market_opportunity

FROM {{ ref('mart_business_ready_products') }}
WHERE rating >= 4.3
  AND rating_count < 100
QUALIFY ROW_NUMBER() OVER (
    PARTITION BY product_id
    ORDER BY opportunity_score DESC
) = 1
