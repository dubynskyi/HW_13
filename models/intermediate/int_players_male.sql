{{ config(schema='intermediate', alias='int_players_male') }}
select
  player_id, player_sk, gender, long_name,
  age, overall, potential,
  value_eur,
  case when value_eur is null or wage_eur > value_eur then null else wage_eur end as wage_eur,
  height_cm, weight_kg,
  club_id, club_name, league_id, league_name,
  player_positions, club_position, preferred_foot,
  pace, shooting, passing, dribbling, defending, physical
from {{ ref('stg_players_male') }}
