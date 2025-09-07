select * from {{ ref('mart_player_profiles_male') }} where coalesce(wage_eur,0) > coalesce(value_eur,0)
union all
select * from {{ ref('mart_player_profiles_female') }} where coalesce(wage_eur,0) > coalesce(value_eur,0)
