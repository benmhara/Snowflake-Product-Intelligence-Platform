import streamlit as st

from components.layout import configure_page, page_title
from utils.queries import executive_metrics


configure_page("Amazon Product Intelligence")
page_title(
    "Amazon Product Intelligence",
    "Executive view across product performance, sentiment, recommendations, and semantic discovery.",
)

try:
    metrics = executive_metrics()
    if not metrics.empty:
        row = metrics.iloc[0]
        cols = st.columns(4)
        cols[0].metric("Products", row.get("TOTAL_PRODUCTS", "-"))
        cols[1].metric("Categories", row.get("TOTAL_CATEGORIES", "-"))
        cols[2].metric("Avg rating", row.get("AVERAGE_RATING", "-"))
        cols[3].metric("High opportunity", row.get("HIGH_OPPORTUNITY_PRODUCTS", "-"))
    else:
        st.info("Run dbt to populate executive metrics.")
except Exception as exc:
    st.warning(f"Connect Snowflake and run dbt to populate the dashboard. Details: {exc}")
