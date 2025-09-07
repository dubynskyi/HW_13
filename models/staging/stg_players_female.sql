{{ config(schema='staging', alias='stg_players_female', materialized='table') }}
with raw as (
  select * from read_csv_auto('{{ var("data_dir") }}/female_players.csv', ignore_errors=true) {{ dev_limit() }}
),
typed as (
  select
    cast(r.player_id as bigint) as player_id,
    'female' as gender,
    lower(trim(r.long_name)) as long_name,
    r.short_name,
    cast(r.age as int) as age,
    cast(r.overall as int) as overall,
    cast(r.potential as int) as potential,
    cast(r.value_eur as bigint) as value_eur,
    cast(r.wage_eur as bigint) as wage_eur,
    cast(r.height_cm as int) as height_cm,
    cast(r.weight_kg as int) as weight_kg,
    cast(r.club_team_id as int) as club_id,
    r.club_name,
    cast(r.league_id as int) as league_id,
    r.league_name,
    cast(r.nationality_id as int) as nationality_id,
    r.nationality_name,
    r.player_positions, r.club_position as club_position, r.preferred_foot,
    cast(r.pace as int) as pace,
    cast(r.shooting as int) as shooting,
    cast(r.passing as int) as passing,
    cast(r.dribbling as int) as dribbling,
    cast(r.defending as int) as defending,
    cast(r.physic as int) as physical
  from raw r
  where r.player_id is not null
),
ranked as (
  select
    t.*,
    row_number() over (
      partition by player_id
      order by overall desc nulls last,
               value_eur desc nulls last,
               wage_eur  desc nulls last
    ) as rn
  from typed t
),
dedup as (
  select * from ranked where rn = 1
),
final as (
  select d.*, {{ sk(['d.player_id']) }} as player_sk
  from dedup d
)
select * from final
