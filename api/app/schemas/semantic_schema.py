from pydantic import BaseModel


class SemanticSearchResult(BaseModel):

    product_name: str

    category: str

    review_content: str

    similarity_score: float