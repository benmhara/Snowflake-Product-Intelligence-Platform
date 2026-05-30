{{ config(materialized='table') }}

SELECT

    product_id,
    product_name,
    category,

    actual_price,
    discounted_price,

    rating,
    rating_count,

    ROUND(
        actual_price - discounted_price,
        2
    ) AS discount_amount,

    ROUND(
        rating * LN(rating_count + 1),
        2
    ) AS popularity_score,

    ROUND(
        rating * (
            (actual_price - discounted_price)
            /
            NULLIF(actual_price, 0)
        ) * 100,
        2
    ) AS value_score

FROM {{ ref('stg_products') }}
