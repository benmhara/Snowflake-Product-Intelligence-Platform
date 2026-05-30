import streamlit as st

from components.layout import configure_page, page_title
from utils.queries import run_query


configure_page("AI Insights")
page_title("AI Insights", "Cortex sentiment and product intelligence flags.")

try:
    df = run_query(
        """
        SELECT product_name, category, sentiment_label, ai_business_flag, opportunity_score
        FROM ai.ai_product_insights
        ORDER BY opportunity_score DESC
        LIMIT 100
        """
    )
    st.dataframe(df, use_container_width=True, hide_index=True)
except Exception as exc:
    st.warning(f"Unable to load AI insights yet. Details: {exc}")
