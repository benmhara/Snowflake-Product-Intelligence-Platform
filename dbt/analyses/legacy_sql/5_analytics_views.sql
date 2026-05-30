USE DATABASE amazon_product_intelligence;
USE SCHEMA gold;

CREATE OR REPLACE VIEW top_products AS
SELECT
    product_name,
    category,
    rating,
    rating_count,
    product_health_score
FROM business_ready_products
ORDER BY product_health_score DESC;