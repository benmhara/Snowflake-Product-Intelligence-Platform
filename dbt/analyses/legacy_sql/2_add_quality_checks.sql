USE DATABASE amazon_product_intelligence;
USE SCHEMA silver;

CREATE OR REPLACE TABLE validated_amazon_products AS
SELECT
    *,

    -- =====================================================
    -- QUALITY FLAGS
    -- =====================================================

    CASE
        WHEN product_name IS NULL OR product_name = ''
        THEN TRUE
        ELSE FALSE
    END AS qc_missing_product_name,

    CASE
        WHEN actual_price < discounted_price
        THEN TRUE
        ELSE FALSE
    END AS qc_invalid_pricing,

    CASE
        WHEN rating < 0 OR rating > 5
        THEN TRUE
        ELSE FALSE
    END AS qc_invalid_rating,

    CASE
        WHEN rating_count < 0
        THEN TRUE
        ELSE FALSE
    END AS qc_invalid_rating_count,

    CASE
        WHEN product_link IS NULL
        THEN TRUE
        ELSE FALSE
    END AS qc_missing_product_link,

    CASE
        WHEN review_content IS NULL
             OR LENGTH(review_content) < 5
        THEN TRUE
        ELSE FALSE
    END AS qc_poor_review_content,

    -- =====================================================
    -- OVERALL RECORD STATUS
    -- =====================================================

    CASE
        WHEN
            product_name IS NULL
            OR actual_price < discounted_price
            OR rating < 0
            OR rating > 5
        THEN 'REJECTED'

        ELSE 'VALID'
    END AS record_status

FROM cleaned_amazon_products;