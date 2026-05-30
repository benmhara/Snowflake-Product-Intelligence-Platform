import streamlit as st


def metric_card(label: str, value):
    st.metric(label, value)
