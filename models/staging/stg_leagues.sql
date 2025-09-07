{{ config(schema='staging', alias='stg_leagues', materialized='table') }}
with all_teams as (
  select league_id, league_name from {{ ref('stg_teams_male') }}
  union all
  select league_id, league_name from {{ ref('stg_teams_female') }}
)
select distinct cast(league_id as int) as league_id, league_name
from all_teams where league_id is not null
