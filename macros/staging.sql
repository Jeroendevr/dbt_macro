-- Macro for selecting most recent ID and extraction column
-- Two flavours
-- Extract only on latest ID if there is a full copy. 
-- Combination of ID where timestamp is greater
{% macro id_on_latest(id, extraction, table) %}
    select {{ id }}, max({{ extraction }}) as latest_extraction_at
    from {{ table }}
    group by {{ id }}
{% endmacro %}

{% macro filter_id_latest(id, extraction, table) %}
    inner join
        ({{ id_on_latest(id, extraction, table) }}) as latest_extraction
        on latest_extraction.latest_extraction_at = {{ table }}.extracted_at

    order by {{ table }}.{{ id }} desc

{% endmacro %}
