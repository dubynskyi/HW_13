{% macro int_or_null(expr) -%} cast(nullif(trim({{ expr }}), '') as integer) {%- endmacro %}
{% macro bigint_or_null(expr) -%} cast(nullif(trim({{ expr }}), '') as bigint) {%- endmacro %}
{% macro num_or_zero(expr) -%} coalesce(cast(nullif({{ expr }}, '') as numeric),0) {%- endmacro %}
