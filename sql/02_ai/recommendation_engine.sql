USE DATABASE amazon_product_intelligence;
USE SCHEMA ai;

CREATE OR REPLACE VIEW ai_recommendations AS
SELECT

    g.product_name,
    g.category,
    g.rating,
    opportunity_score,
    product_health_score,
    sentiment_score,

    -- =====================================================
    -- RECOMMENDATION SCORE
    -- =====================================================

    ROUND(
        (
            product_health_score * 0.4
            +
            opportunity_score * 0.3
            +
            sentiment_score * 10 * 0.3
        ),
        2
    ) AS recommendation_score

FROM amazon_product_intelligence.analytics.mart_business_ready_products g
LEFT JOIN ai_sentiment s
    ON g.review_id = s.review_id

ORDER BY recommendation_score DESC;
