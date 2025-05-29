with running_sum_salary as (
    select
        employee_id,
        experience,
        salary,
        sum(salary)
            over (
                partition by experience
                order by experience desc, salary asc, employee_id asc
            )
            as running_sum
    from
        candidates
)

select
    'Senior' as experience,
    count(employee_id) as accepted_candidates
from running_sum_salary
where running_sum <= 70000 and experience = 'Senior'

union all

select
    'Junior' as experience,
    count(employee_id) as accepted_candidates
from running_sum_salary
where
    running_sum
    <= 70000 - (
        select coalesce(max(running_sum), 0) from running_sum_salary
        where running_sum <= 70000 and experience = 'Senior'
    )
    and experience = 'Junior'