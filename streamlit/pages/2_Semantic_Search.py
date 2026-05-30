import streamlit as st

from components.layout import configure_page, page_title
from utils.queries import semantic_search


configure_page("Semantic Search")
page_title("Semantic Search", "Search product reviews by meaning, not only keywords.")

query = st.text_input("Search", placeholder="wireless headphones with strong battery life")
limit = st.slider("Results", 5, 30, 10)

if query:
    try:
        st.dataframe(semantic_search(query, limit), use_container_width=True, hide_index=True)
    except Exception as exc:
        st.warning(f"Unable to run semantic search yet. Details: {exc}")
