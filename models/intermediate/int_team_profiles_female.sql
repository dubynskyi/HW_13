{{ config(schema='intermediate', alias='int_team_profiles_female') }}
with p as (select * from {{ ref('int_players_female') }})
select club_id,
       max(club_name) as club_name,
       max(league_id) as league_id,
       max(league_name) as league_name,
       count(*) as players_count,
       avg(overall) as avg_overall,
       sum(coalesce(value_eur,0)) as total_value_eur,
       sum(coalesce(wage_eur,0)) as total_wage_eur
from p group by club_id
