-- =====================================================
-- FILE FORMAT
-- =====================================================

USE DATABASE amazon_product_intelligence;
USE SCHEMA bronze;

CREATE OR REPLACE FILE FORMAT amazon_csv_format
TYPE = CSV
PARSE_HEADER = TRUE
FIELD_DELIMITER = ','
SKIP_HEADER = 0
FIELD_OPTIONALLY_ENCLOSED_BY = '"'
EMPTY_FIELD_AS_NULL = TRUE
TRIM_SPACE = TRUE
ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE;

-- Verify
SHOW FILE FORMATS;