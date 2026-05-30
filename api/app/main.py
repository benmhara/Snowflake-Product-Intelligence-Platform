from fastapi import FastAPI

from app.routes.products import router as products_router
from app.routes.recommendations import router as recommendations_router
from app.routes.semantic_search import router as semantic_router

app = FastAPI(
    title="Amazon Product Intelligence API",
    version="2.0.0"
)

app.include_router(products_router)
app.include_router(recommendations_router)
app.include_router(semantic_router)


@app.get("/")
def root():
    return {
        "message": "Amazon Product Intelligence Platform",
        "architecture": "Snowflake + dbt + Cortex AI + semantic search"
    }
