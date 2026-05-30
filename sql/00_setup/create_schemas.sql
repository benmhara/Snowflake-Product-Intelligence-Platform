-- =====================================================
-- SCHEMA CREATION
-- =====================================================

USE DATABASE amazon_product_intelligence;

-- Platform schemas
CREATE OR REPLACE SCHEMA bronze;
CREATE OR REPLACE SCHEMA staging;
CREATE OR REPLACE SCHEMA intermediate;

-- AI Layer
CREATE OR REPLACE SCHEMA ai;

-- Analytics Layer
CREATE OR REPLACE SCHEMA analytics;

-- Governance & Security
CREATE OR REPLACE SCHEMA governance;

-- Sandbox / experimentation
CREATE OR REPLACE SCHEMA sandbox;

-- Verify
SHOW SCHEMAS;
