import streamlit as st


def configure_page(title: str):
    st.set_page_config(
        page_title=title,
        layout="wide",
    )


def page_title(title: str, caption: str):
    st.title(title)
    st.caption(caption)
