USE DATABASE amazon_product_intelligence;
USE SCHEMA silver;

SELECT

    COUNT(*) AS total_records,

    COUNT_IF(qc_missing_product_name) AS missing_product_names,

    COUNT_IF(qc_invalid_pricing) AS invalid_pricing_records,

    COUNT_IF(qc_invalid_rating) AS invalid_ratings,

    COUNT_IF(qc_invalid_rating_count) AS invalid_rating_counts,

    COUNT_IF(qc_missing_product_link) AS missing_links,

    COUNT_IF(qc_poor_review_content) AS poor_reviews,

    COUNT_IF(record_status = 'REJECTED') AS rejected_records,

    ROUND(
        100 * COUNT_IF(record_status = 'VALID') / COUNT(*),
        2
    ) AS valid_record_percentage

FROM validated_amazon_products;