select * from {{ ref('int_team_profiles_male') }} where avg_overall < 40 or avg_overall > 100
union all
select * from {{ ref('int_team_profiles_female') }} where avg_overall < 40 or avg_overall > 100
