{{ config(schema='intermediate', alias='int_league_insights_female') }}
with tp as (select * from {{ ref('int_team_profiles_female') }}),
pl as (select * from {{ ref('int_players_female') }}),
young as (
  select league_id,
         max(case when age <= 23 and potential > 85 then true else false end) as has_young_talents
  from pl group by league_id
),
league_stats as (
  select league_id, max(league_name) as league_name, avg(avg_overall) as league_avg_overall
  from tp group by league_id
)
select s.league_id, s.league_name, s.league_avg_overall, coalesce(y.has_young_talents,false) as has_young_talents
from league_stats s left join young y using (league_id)
