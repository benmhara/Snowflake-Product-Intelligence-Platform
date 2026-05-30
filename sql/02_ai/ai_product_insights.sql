USE DATABASE amazon_product_intelligence;
USE SCHEMA ai;

CREATE OR REPLACE VIEW ai_product_insights AS
SELECT

    g.product_name,
    g.category,
    g.rating,
    g.rating_count,
    g.opportunity_score,

    s.sentiment_score,
    s.sentiment_label,

    -- =====================================================
    -- AI FLAGS
    -- =====================================================

    CASE
        WHEN g.rating >= 4.5
             AND s.sentiment_score < 0
        THEN 'Suspicious Product'

        WHEN g.rating >= 4.3
             AND g.rating_count < 100
        THEN 'Hidden Gem'

        WHEN s.sentiment_score < -0.5
        THEN 'Customer Risk'

        ELSE 'Normal'
    END AS ai_business_flag

FROM amazon_product_intelligence.analytics.mart_business_ready_products g
LEFT JOIN ai_sentiment s
    ON g.review_id = s.review_id;
