{{ config(schema='staging', alias='stg_teams_female', materialized='table') }}
with raw as (
  select * from read_csv_auto('{{ var("data_dir") }}/female_teams.csv', ignore_errors=true) {{ dev_limit() }}
),
base as (
  select
    cast(team_id as int)   as club_id,
    team_name              as club_name,
    cast(league_id as int) as league_id,
    league_name
  from raw
  where team_id is not null
),
dedup as (
  select club_id,
         min(club_name)   as club_name,
         min(league_id)   as league_id,
         min(league_name) as league_name
  from base
  group by club_id
)
select * from dedup
