{% test wage_le_value(model, column_name, value_col) %}
  select *
  from {{ model }}
  where coalesce({{ column_name }}, 0) > coalesce({{ value_col }}, 0)
{% endtest %}
