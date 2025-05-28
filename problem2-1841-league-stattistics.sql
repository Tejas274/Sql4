with team_stats_pivot AS
(
    select
    home_team_id as team,
    home_team_goals as goal_for,
    away_team_goals as goal_against,
    case
    when home_team_goals > away_team_goals then 3
    when home_team_goals < away_team_goals then 0
    else
    1
    END AS 'points'
    from Matches

    union all

    select
    away_team_id as team,
    away_team_goals as goal_for,
    home_team_goals as goal_against,
    case
    when away_team_goals > home_team_goals then 3
    when away_team_goals < home_team_goals then 0
    else
    1
    END AS 'points'
    from Matches

)

select
Teams.team_name,
count(ts.team) as  matches_played,
sum(ts.points) as points,
sum(ts.goal_for) as goal_for,
sum(ts.goal_against) as goal_against,
sum(ts.goal_for) - sum(ts.goal_against) AS goal_diff
from team_stats_pivot ts
inner join
Teams
on ts.team = Teams.team_id
group by team
order by points desc, goal_diff desc,team_name