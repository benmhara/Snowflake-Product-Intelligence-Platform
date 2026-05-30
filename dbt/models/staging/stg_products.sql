{{ config(materialized='view') }}

SELECT

    product_id,

    TRIM(product_name) AS product_name,

    LOWER(TRIM(category)) AS category,

    TRY_TO_NUMBER(
        REGEXP_REPLACE(discounted_price, '[^0-9.]', '')
    ) AS discounted_price,

    TRY_TO_NUMBER(
        REGEXP_REPLACE(actual_price, '[^0-9.]', '')
    ) AS actual_price,

    TRY_TO_DOUBLE(rating) AS rating,

    TRY_TO_NUMBER(
        REGEXP_REPLACE(rating_count, '[^0-9]', '')
    ) AS rating_count,

    about_product,

    img_link,
    product_link

FROM {{ source('bronze', 'raw_amazon_products') }}