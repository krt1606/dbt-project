{% macro clean_columns(column_name) %}
    trim(lower({{ column_name }}))
{% endmacro %}