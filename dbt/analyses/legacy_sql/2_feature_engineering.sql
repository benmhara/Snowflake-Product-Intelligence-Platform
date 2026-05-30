USE DATABASE amazon_product_intelligence;
USE SCHEMA gold;

CREATE OR REPLACE TABLE enriched_amazon_products AS
SELECT
    *,

    -- =====================================================
    -- VALUE SCORE
    -- =====================================================

    ROUND(
        rating * discount_percentage,
        2
    ) AS value_score,

    -- =====================================================
    -- POPULARITY SCORE
    -- =====================================================

    ROUND(
        rating * LN(rating_count + 1),
        2
    ) AS popularity_score,

    -- =====================================================
    -- OPPORTUNITY SCORE
    -- =====================================================

    ROUND(
        (rating * discount_percentage)
        / NULLIF(LN(rating_count + 1), 0),
        2
    ) AS opportunity_score,

    -- =====================================================
    -- REVIEW LENGTH
    -- =====================================================

    LENGTH(review_content) AS review_length,

    -- =====================================================
    -- PRICE SEGMENT
    -- =====================================================

    CASE
        WHEN discounted_price < 50 THEN 'Budget'

        WHEN discounted_price < 200 THEN 'Mid Range'

        ELSE 'Premium'
    END AS price_segment,

    -- =====================================================
    -- DEAL LEVEL
    -- =====================================================

    CASE
        WHEN discount_percentage >= 50 THEN 'Excellent Deal'

        WHEN discount_percentage >= 30 THEN 'Good Deal'

        WHEN discount_percentage >= 15 THEN 'Average Deal'

        ELSE 'Low Deal'
    END AS deal_level

FROM curated_amazon_products;