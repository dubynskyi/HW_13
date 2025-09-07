{% test team_overall_bounds(model, column_name) %}
  select *
  from {{ model }}
  where {{ column_name }} < 40 or {{ column_name }} > 100
{% endtest %}
