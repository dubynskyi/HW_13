{% macro sk(cols) -%}
md5(
  {% for c in cols -%}
    coalesce(cast({{ c }} as varchar),'')
    {%- if not loop.last %} || '||' || {% endif -%}
  {%- endfor -%}
)
{%- endmacro %}
