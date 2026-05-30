-- =====================================================
-- UPLOAD FILE TO STAGE
-- =====================================================

USE DATABASE amazon_product_intelligence;
USE SCHEMA bronze;

PUT file://C:\Users\benmh\OneDrive\Bureau\amazon.csv
@amazon_raw_stage
AUTO_COMPRESS = TRUE
OVERWRITE = TRUE