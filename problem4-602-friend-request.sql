with cte_friends as
(
    select requester_id as id
    from RequestAccepted
    union all
    select accepter_id as id
    from RequestAccepted
)

select distinct id,
count(id) as num
from cte_friends
group by id
order by num desc
limit 1