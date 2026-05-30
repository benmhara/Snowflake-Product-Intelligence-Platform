import streamlit as st

from components.layout import configure_page, page_title
from utils.queries import semantic_search


configure_page("AI Chat")
page_title("AI Chat", "Retrieve review context for product questions.")

question = st.text_input("Question", placeholder="Which products have strong reviews for durability?")

if question:
    try:
        context = semantic_search(question, 5)
        st.dataframe(context, use_container_width=True, hide_index=True)
    except Exception as exc:
        st.warning(f"Unable to retrieve RAG context yet. Details: {exc}")
