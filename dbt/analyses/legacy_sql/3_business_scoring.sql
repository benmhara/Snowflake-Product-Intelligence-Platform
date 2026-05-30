USE DATABASE amazon_product_intelligence;
USE SCHEMA gold;

CREATE OR REPLACE TABLE business_ready_products AS
SELECT
    *,

    -- =====================================================
    -- CUSTOMER SATISFACTION
    -- =====================================================

    CASE
        WHEN rating >= 4.5
             AND rating_count >= 1000
        THEN 'Highly Trusted'

        WHEN rating >= 4
        THEN 'Trusted'

        WHEN rating >= 3
        THEN 'Average'

        ELSE 'Risky'
    END AS customer_trust_level,

    -- =====================================================
    -- MARKET POTENTIAL
    -- =====================================================

    CASE
        WHEN opportunity_score >= 50
        THEN 'High Potential'

        WHEN opportunity_score >= 20
        THEN 'Medium Potential'

        ELSE 'Low Potential'
    END AS market_potential,

    -- =====================================================
    -- PRODUCT HEALTH SCORE
    -- =====================================================

    ROUND(
        (
            (rating * 0.5)
            +
            (discount_percentage * 0.3)
            +
            (LN(rating_count + 1) * 0.2)
        ),
        2
    ) AS product_health_score

FROM enriched_amazon_products;