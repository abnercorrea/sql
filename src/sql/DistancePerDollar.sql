-- https://platform.stratascratch.com/coding/10302-distance-per-dollar

WITH ym_dtd AS (
    SELECT
        request_date,
        TO_CHAR(request_date, 'YYYY-MM') AS year_month,
        distance_to_travel / monetary_cost AS distance_per_dollar
    FROM uber_request_logs
)
SELECT
    request_date,
    year_month,
    ROUND(
        ABS(
            distance_per_dollar -
            AVG(distance_per_dollar) OVER (PARTITION BY year_month)
        )::NUMERIC,
        2
    ) AS dpd_diff
FROM ym_dtd
ORDER BY request_date
;