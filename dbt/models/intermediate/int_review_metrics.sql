{{ config(materialized='table') }}

SELECT

    review_id,
    product_id,

    LENGTH(review_content) AS review_length,

    CASE
        WHEN LENGTH(review_content) > 300
        THEN 'Detailed'

        WHEN LENGTH(review_content) > 100
        THEN 'Moderate'

        ELSE 'Short'
    END AS review_quality

FROM {{ ref('stg_reviews') }}
