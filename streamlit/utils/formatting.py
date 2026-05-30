def format_number(value):
    if value is None:
        return "-"
    return f"{value:,.0f}"


def format_score(value):
    if value is None:
        return "-"
    return f"{value:,.2f}"
