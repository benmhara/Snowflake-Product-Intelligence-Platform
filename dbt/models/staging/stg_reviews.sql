{{ config(materialized='view') }}

SELECT

    review_id,
    product_name,
    product_id,
    user_id,

    TRIM(user_name) AS user_name,

    TRIM(review_title) AS review_title,

    TRIM(review_content) AS review_content

FROM {{ source('bronze', 'raw_amazon_products') }}