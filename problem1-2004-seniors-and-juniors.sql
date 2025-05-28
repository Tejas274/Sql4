with running_sum_salary AS (select
employee_id,
experience,
salary,
sum(salary) over (partition by experience order by  experience desc,salary,employee_id) AS running_sum
from
Candidates)


select
'Senior' AS experience,
count(employee_id) AS accepted_candidates
from running_sum_salary
where running_sum <=  70000 and experience = 'Senior'


union all


select
'Junior' AS experience,
count(employee_id) AS accepted_candidates
from running_sum_salary
where running_sum <= 70000 - (select coalesce(max(running_sum),0) from running_sum_salary where running_sum <=  70000 and experience = 'Senior')
and experience = 'Junior'