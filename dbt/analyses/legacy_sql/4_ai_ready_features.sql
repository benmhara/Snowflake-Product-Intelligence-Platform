USE DATABASE amazon_product_intelligence;
USE SCHEMA gold;

CREATE OR REPLACE VIEW hidden_gems AS
SELECT
    product_name,
    category,
    rating,
    opportunity_score
FROM business_ready_products
WHERE
    rating >= 4.3
    AND rating_count < 500
ORDER BY opportunity_score DESC;

CREATE OR REPLACE VIEW risky_products AS
SELECT
    product_name,
    rating,
    rating_count,
    customer_trust_level
FROM business_ready_products
WHERE customer_trust_level = 'Risky';