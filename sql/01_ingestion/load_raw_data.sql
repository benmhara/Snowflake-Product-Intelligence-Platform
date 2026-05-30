-- =====================================================
-- COPY INTO RAW TABLE
-- =====================================================

USE DATABASE amazon_product_intelligence;
USE SCHEMA bronze;

-- Load data
COPY INTO RAW_AMAZON_PRODUCTS
FROM @amazon_raw_stage/amazon.csv
FILE_FORMAT = (FORMAT_NAME = amazon_csv_format)
MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE
ON_ERROR = CONTINUE;

SELECT * FROM RAW_AMAZON_PRODUCTS;