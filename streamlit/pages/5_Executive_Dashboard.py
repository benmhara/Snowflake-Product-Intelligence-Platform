import streamlit as st

from components.layout import configure_page, page_title
from utils.queries import executive_metrics, run_query


configure_page("Executive Dashboard")
page_title("Executive Dashboard", "Category and portfolio performance.")

try:
    st.dataframe(executive_metrics(), use_container_width=True, hide_index=True)
    category_df = run_query(
        """
        SELECT category, product_count, average_rating, average_value_score
        FROM analytics.mart_category_performance
        ORDER BY product_count DESC
        """
    )
    st.dataframe(category_df, use_container_width=True, hide_index=True)
except Exception as exc:
    st.warning(f"Unable to load executive dashboard yet. Details: {exc}")
