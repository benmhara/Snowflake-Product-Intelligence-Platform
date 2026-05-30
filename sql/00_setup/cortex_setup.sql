-- =====================================================
-- CORTEX AI SETUP
-- =====================================================

USE ROLE amazon_admin;
USE DATABASE amazon_product_intelligence;

-- Cortex functions are available through Snowflake-managed services.
-- Keep model access, warehouse sizing, and AI cost monitoring in this layer.
SELECT
    'Cortex AI setup validated' AS status,
    CURRENT_DATABASE() AS database_name,
    CURRENT_ROLE() AS role_name;
