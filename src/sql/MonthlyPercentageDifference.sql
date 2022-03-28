-- https://platform.stratascratch.com/coding/10319-monthly-percentage-difference
-- Given a table of purchases by date, calculate the month-over-month percentage change in revenue.
-- The output should include the year-month date (YYYY-MM) and percentage change, rounded to the 2nd decimal point,
-- and sorted from the beginning of the year to the end of the year.
-- The percentage change column will be populated from the 2nd month forward and can be calculated as:
-- ((this month's revenue - last month's revenue) / last month's revenue)*100.

WITH monthly_revenue AS (
    SELECT
        TO_CHAR(created_at, 'YYYY-MM') AS year_month,
        SUM(value) AS revenue
    FROM sf_transactions
    GROUP BY year_month
),
revenue_with_prev AS (
    SELECT
        year_month,
        revenue,
        LAG(revenue, 1) OVER (ORDER BY year_month) AS previous_revenue
    FROM monthly_revenue
)
SELECT
    year_month,
    ROUND(100 * (revenue - previous_revenue) / previous_revenue, 2) AS revenue_change
FROM revenue_with_prev
;
