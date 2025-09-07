{% macro classify_role(pos, overall, pace, pass, defn, shooting, drib, phys) -%}
case
  when ({{ pos }} ilike '%RB%' or {{ pos }} ilike '%LB%')
       and coalesce({{ pace }},0)>=75 and coalesce({{ pass }},0)>=65 then 'Wingback'
  when ({{ pos }} ilike '%ST%' or {{ pos }} ilike '%CF%')
       and coalesce({{ shooting }},0)>=78 and coalesce({{ overall }},0)>=75 then 'Poacher'
  when ({{ pos }} ilike '%CM%' or {{ pos }} ilike '%CDM%')
       and coalesce({{ pass }},0)>=78 and coalesce({{ drib }},0)>=70 then 'Regista'
  when {{ pos }} ilike '%CB%' and coalesce({{ defn }},0)>=80 then 'Stopper'
  when coalesce({{ overall }},0)>=84 then 'Star'
  else 'Versatile'
end
{%- endmacro %}
