{% macro dev_limit() -%}
  {% if target.name in ['dev','default'] and var('row_limit',0)|int > 0 %}
    limit {{ var('row_limit') }}
  {% endif %}
{%- endmacro %}
