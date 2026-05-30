USE DATABASE amazon_product_intelligence;
USE SCHEMA ai;

CREATE OR REPLACE TABLE ai_sentiment AS
SELECT

    product_id,
    product_name,
    category,
    review_id,
    review_title,
    review_content,
    rating,
    rating_count,

    -- =====================================================
    -- SENTIMENT SCORE
    -- =====================================================

    SNOWFLAKE.CORTEX.SENTIMENT(review_content)
    AS sentiment_score,

    -- =====================================================
    -- SENTIMENT LABEL
    -- =====================================================

    CASE
        WHEN SNOWFLAKE.CORTEX.SENTIMENT(review_content) > 0.3
        THEN 'Positive'

        WHEN SNOWFLAKE.CORTEX.SENTIMENT(review_content) < -0.3
        THEN 'Negative'

        ELSE 'Neutral'
    END AS sentiment_label,

    CURRENT_TIMESTAMP() AS ai_processed_at

FROM amazon_product_intelligence.analytics.mart_business_ready_products
WHERE review_content IS NOT NULL;
