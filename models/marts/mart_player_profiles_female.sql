{{ config(schema='marts', alias='mart_player_profiles_female') }}
with b as (select * from {{ ref('int_players_female') }})
select
  *,
  case when age < 21 then 'U21'
       when age between 21 and 28 then 'Prime'
       else 'Veteran' end as age_group,
  {{ classify_role('player_positions','overall','pace','passing','defending','shooting','dribbling','physical') }} as player_role
from b
