-- https://platform.stratascratch.com/coding-question?id=9897&python=

-- Find the employee with the highest salary per department.
-- Output the department name, employee's first name along with the corresponding salary.

-- Using sub query instead of CTE, since in PostgresSQL CTE are materialized.
-- https://hakibenita.com/be-careful-with-cte-in-postgre-sql
select department, first_name, salary
from (
    select
        department, first_name, salary,
        row_number() over w
    from employee
    window w as (
        partition by department
        order by salary desc
    )
) e
where row_number = 1
;
