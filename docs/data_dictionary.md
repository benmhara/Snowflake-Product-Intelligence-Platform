# Data Dictionary

## Core Product Fields

| Field | Description |
| --- | --- |
| `product_id` | Unique product identifier from the source dataset |
| `product_name` | Product display name |
| `category` | Normalized product category |
| `actual_price` | Parsed original price |
| `discounted_price` | Parsed discounted price |
| `rating` | Numeric customer rating |
| `rating_count` | Number of ratings |

## Intelligence Fields

| Field | Description |
| --- | --- |
| `popularity_score` | Rating weighted by review volume |
| `value_score` | Discount-adjusted value signal |
| `opportunity_score` | Combined business opportunity score |
| `product_health_score` | Rating and review-volume health score |
| `sentiment_score` | Cortex sentiment score from review content |
| `review_embedding` | Vector embedding for semantic search and RAG |
| `recommendation_score` | Combined recommendation ranking score |
