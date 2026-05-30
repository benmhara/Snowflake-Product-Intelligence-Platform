import streamlit as st

from components.layout import configure_page, page_title
from utils.queries import recommendations


configure_page("Recommendations")
page_title("Recommendations", "AI-ready product recommendation ranking.")

limit = st.slider("Rows", 5, 50, 25)

try:
    st.dataframe(recommendations(limit), use_container_width=True, hide_index=True)
except Exception as exc:
    st.warning(f"Unable to load recommendations yet. Details: {exc}")
