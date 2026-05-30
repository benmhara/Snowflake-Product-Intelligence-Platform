USE DATABASE amazon_product_intelligence;
USE SCHEMA ai;

CREATE OR REPLACE VIEW rag_retrieval_context AS
SELECT
    product_id,
    review_id,
    product_name,
    category,
    rag_context,
    review_embedding
FROM ai_rag_context;
