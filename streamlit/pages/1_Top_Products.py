import streamlit as st

from components.layout import configure_page, page_title
from utils.queries import top_products


configure_page("Top Products")
page_title("Top Products", "Products ranked by popularity score.")

limit = st.slider("Rows", 5, 50, 25)

try:
    st.dataframe(top_products(limit), use_container_width=True, hide_index=True)
except Exception as exc:
    st.warning(f"Unable to load top products yet. Details: {exc}")
