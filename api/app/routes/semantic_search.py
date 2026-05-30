from typing import List

from fastapi import (
    APIRouter,
    HTTPException,
    Query
)

from app.schemas.semantic_schema import (
    SemanticSearchResult
)

from app.services.semantic_service import (
    search_semantic_products
)

from app.core.exceptions import (
    SemanticSearchError
)

router = APIRouter(
    prefix="/semantic-search",
    tags=["Semantic Search"]
)


@router.get(
    "/",
    response_model=List[SemanticSearchResult]
)
def semantic_search(

    query: str = Query(
        ...,
        min_length=3,
        max_length=200
    ),

    limit: int = Query(
        10,
        ge=1,
        le=50
    )
):

    try:

        return search_semantic_products(
            query=query,
            limit=limit
        )

    except SemanticSearchError as e:

        raise HTTPException(
            status_code=500,
            detail=e.detail
        )