-- =====================================================
-- TAG CREATION
-- =====================================================
USE DATABASE amazon_product_intelligence;

CREATE OR REPLACE TAG environment;

CREATE OR REPLACE TAG project;

CREATE OR REPLACE TAG data_tier;

-- =====================================================
-- APPLY TAGS
-- =====================================================

ALTER DATABASE amazon_product_intelligence
SET TAG project = 'amazon_product_intelligence';

ALTER SCHEMA bronze
SET TAG data_tier = 'bronze';

ALTER SCHEMA silver
SET TAG data_tier = 'silver';

ALTER SCHEMA gold
SET TAG data_tier = 'gold';