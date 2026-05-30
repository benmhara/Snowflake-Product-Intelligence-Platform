from fastapi import APIRouter

from app.database import get_connection

router = APIRouter(
    prefix="/recommendations",
    tags=["Recommendations"]
)


@router.get("/")
def get_recommendations():

    conn = get_connection()

    cursor = conn.cursor()

    query = """
        SELECT
            product_name,
            recommendation_score
        FROM AI.AI_RECOMMENDATIONS
        ORDER BY recommendation_score DESC
        LIMIT 10
    """

    cursor.execute(query)

    rows = cursor.fetchall()

    results = []

    for row in rows:

        results.append({
            "product_name": row[0],
            "recommendation_score": row[1]
        })

    cursor.close()
    conn.close()

    return results
