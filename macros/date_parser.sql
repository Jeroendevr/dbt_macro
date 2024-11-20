{% macro pcm_date(date) %}
-- When parsing dates month is sometimes 0 which cannot be parsed to a date.
-- Therefore this macro
-- pcm("202309")
-- return
-- 2023-09-01 as date
-- if formatting is incorrect result is null
{% if date | length == 6 and date[4:]|int > 0 and date[4:]|int <= 12 %}
{% set parsed_date = modules.datetime.datetime.strptime(date, "%Y%m") %}
safe_cast
('{{parsed_date.strftime('%Y-%m-%d')}}' as date)
    {% else %} null
    {% endif %}
{% endmacro %}

{% macro pcm_date_month(date) %}
    safe_cast(substr(safe_cast({{ date }} as string), 5, 2) as int64)
{% endmacro %}