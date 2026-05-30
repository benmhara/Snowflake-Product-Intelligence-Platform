import plotly.express as px
import streamlit as st


def bar_chart(df, x: str, y: str, title: str):
    fig = px.bar(df, x=x, y=y, title=title)
    st.plotly_chart(fig, use_container_width=True)
