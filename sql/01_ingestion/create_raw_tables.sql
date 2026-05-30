-- =====================================================
-- COPY INTO RAW TABLE
-- =====================================================

USE DATABASE amazon_product_intelligence;
USE SCHEMA bronze;

CREATE OR REPLACE TABLE raw_amazon_products
USING TEMPLATE (
    SELECT ARRAY_AGG(
        OBJECT_CONSTRUCT(
            'COLUMN_NAME', UPPER("COLUMN_NAME"),
            'TYPE', "TYPE",
            'NULLABLE', "NULLABLE",
            'EXPRESSION', "EXPRESSION"
        )
    )
    FROM TABLE(
        INFER_SCHEMA(
            LOCATION => '@amazon_raw_stage',
            FILE_FORMAT => 'amazon_csv_format'
        )
    )
);

SELECT * FROM RAW_AMAZON_PRODUCTS;

SHOW COLUMNS IN TABLE RAW_AMAZON_PRODUCTS;

SELECT ARRAY_AGG(
        OBJECT_CONSTRUCT(
            'COLUMN_NAME', UPPER("COLUMN_NAME"),
            'TYPE', "TYPE",
            'NULLABLE', "NULLABLE",
            'EXPRESSION', "EXPRESSION"
        )
    )
    FROM TABLE(
        INFER_SCHEMA(
            LOCATION => '@amazon_raw_stage',
            FILE_FORMAT => 'amazon_csv_format'
        )
    )



