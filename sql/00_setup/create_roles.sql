-- =====================================================
-- ROLE CREATION
-- =====================================================

USE ROLE ACCOUNTADMIN;

-- =====================================================
-- CREATE ROLES
-- =====================================================

CREATE OR REPLACE ROLE amazon_admin;

CREATE OR REPLACE ROLE amazon_engineer;

CREATE OR REPLACE ROLE amazon_analyst;

CREATE OR REPLACE ROLE amazon_readonly;

-- =====================================================
-- WAREHOUSE ACCESS
-- =====================================================

GRANT USAGE
ON WAREHOUSE amazon_wh
TO ROLE amazon_engineer;

GRANT USAGE
ON WAREHOUSE amazon_wh
TO ROLE amazon_analyst;

GRANT USAGE
ON WAREHOUSE amazon_wh
TO ROLE amazon_readonly;

-- =====================================================
-- DATABASE ACCESS
-- =====================================================

GRANT USAGE
ON DATABASE amazon_product_intelligence
TO ROLE amazon_engineer;

GRANT USAGE
ON DATABASE amazon_product_intelligence
TO ROLE amazon_analyst;

GRANT USAGE
ON DATABASE amazon_product_intelligence
TO ROLE amazon_readonly;

-- =====================================================
-- SCHEMA ACCESS
-- =====================================================

GRANT ALL PRIVILEGES
ON ALL SCHEMAS IN DATABASE amazon_product_intelligence
TO ROLE amazon_engineer;

GRANT USAGE
ON ALL SCHEMAS IN DATABASE amazon_product_intelligence
TO ROLE amazon_analyst;

GRANT USAGE
ON ALL SCHEMAS IN DATABASE amazon_product_intelligence
TO ROLE amazon_readonly;

-- =====================================================
-- TABLE ACCESS
-- =====================================================

GRANT SELECT
ON ALL TABLES IN DATABASE amazon_product_intelligence
TO ROLE amazon_analyst;

GRANT SELECT
ON ALL TABLES IN DATABASE amazon_product_intelligence
TO ROLE amazon_readonly;

-- =====================================================
-- FUTURE GRANTS
-- =====================================================

GRANT SELECT
ON FUTURE TABLES IN DATABASE amazon_product_intelligence
TO ROLE amazon_analyst;

GRANT SELECT
ON FUTURE TABLES IN DATABASE amazon_product_intelligence
TO ROLE amazon_readonly;

-- =====================================================
-- ROLE HIERARCHY
-- =====================================================

GRANT ROLE amazon_readonly TO ROLE amazon_analyst;

GRANT ROLE amazon_analyst TO ROLE amazon_engineer;

GRANT ROLE amazon_engineer TO ROLE amazon_admin;

GRANT ROLE amazon_admin TO USER MALEK;