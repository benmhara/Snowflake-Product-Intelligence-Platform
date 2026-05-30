USE DATABASE amazon_product_intelligence;
USE SCHEMA silver;

CREATE OR REPLACE TABLE cleaned_amazon_products AS
SELECT

    -- Original identifiers
    product_id,
    review_id,
    user_id,

    -- Clean text fields
    TRIM(product_name) AS product_name,
    LOWER(TRIM(category)) AS category,
    TRIM(user_name) AS user_name,
    TRIM(review_title) AS review_title,
    TRIM(review_content) AS review_content,
    TRIM(about_product) AS about_product,

    -- Clean prices (remove currency symbols like ₹ or $)
    TRY_TO_NUMBER(
        REGEXP_REPLACE(discounted_price, '[^0-9.]', '')
    ) AS discounted_price,

    TRY_TO_NUMBER(
        REGEXP_REPLACE(actual_price, '[^0-9.]', '')
    ) AS actual_price,

    -- Clean discount %
    TRY_TO_NUMBER(
        REGEXP_REPLACE(discount_percentage, '[^0-9.]', '')
    ) AS discount_percentage,

    -- Ratings
    TRY_TO_DOUBLE(rating) AS rating,

    -- Rating count
    TRY_TO_NUMBER(
        REGEXP_REPLACE(rating_count, '[^0-9]', '')
    ) AS rating_count,

    -- URLs
    img_link,
    product_link,

    -- Metadata
    CURRENT_TIMESTAMP() AS silver_loaded_at

FROM amazon_product_intelligence.bronze.raw_amazon_products;