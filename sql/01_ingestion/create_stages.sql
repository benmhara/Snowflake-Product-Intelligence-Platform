-- =====================================================
-- INTERNAL STAGE
-- =====================================================

USE DATABASE amazon_product_intelligence;
USE SCHEMA bronze;

CREATE OR REPLACE STAGE amazon_raw_stage
FILE_FORMAT = amazon_csv_format;

-- Verify
SHOW STAGES;