{{ config(schema='marts', alias='mart_team_dashboard') }}
with players as (
  select * from {{ ref('int_players_male') }}
  union all
  select * from {{ ref('int_players_female') }}
),
team_thr as (select club_id, quantile(value_eur,0.4) as v40 from players group by club_id),
ranked as (select *, row_number() over (partition by club_id order by overall desc) as rn from players),
top3 as (select club_id, group_concat(long_name, ', ') as key_players from ranked where rn<=3 group by club_id),
overachievers as (
  select p.club_id, group_concat(p.long_name, ', ') as overachievers
  from players p join team_thr t using (club_id)
  where p.overall >= (select avg(pp.overall) from players pp where pp.club_id=p.club_id) + 5
    and coalesce(p.value_eur,0) <= t.v40
  group by p.club_id
),
team_stats as (
  select club_id, max(club_name) as club_name, max(league_id) as league_id, max(league_name) as league_name,
         count(*) as players_total, avg(overall) as avg_overall,
         sum(coalesce(value_eur,0)) as total_value_eur, sum(coalesce(wage_eur,0)) as total_wage_eur
  from players group by club_id
)
select s.*, coalesce(t.key_players,'') as key_players, coalesce(o.overachievers,'') as overachievers
from team_stats s left join top3 t using (club_id) left join overachievers o using (club_id)
