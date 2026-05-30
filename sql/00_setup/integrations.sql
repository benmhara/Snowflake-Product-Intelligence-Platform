-- =====================================================
-- ENVIRONMENT SETUP
-- =====================================================

USE ROLE amazon_admin;

USE WAREHOUSE amazon_wh;

USE DATABASE amazon_product_intelligence;

USE SCHEMA bronze;

-- Session validation
SELECT CURRENT_ROLE();
SELECT CURRENT_WAREHOUSE();
SELECT CURRENT_DATABASE();
SELECT CURRENT_SCHEMA();