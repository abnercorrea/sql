-- https://platform.stratascratch.com/coding-question?id=9915&python=

with period_orders as (
    select cust_id, order_date, sum(order_cost * order_quantity) total_cost
    from orders
    where order_date between '2019-02-01' and '2019-05-01'
    group by cust_id, order_date
)
select c.first_name, o.order_date, o.total_cost
from period_orders o join customers c on o.cust_id = c.id
where o.total_cost = (select max(total_cost) from period_orders)
order by c.first_name
;
