-- https://platform.stratascratch.com/coding-question?id=10300
-- Find the total number of downloads for paying and non-paying users by date.
-- Include only records where non-paying customers have more downloads than paying customers.
-- The output should be sorted by earliest date first and contain 3 columns date, non-paying downloads, paying downloads.

WITH user_downloads AS (
    SELECT date, downloads, paying_customer
    FROM ms_user_dimension u
    JOIN ms_acc_dimension a ON u.acc_id = a.acc_id
    JOIN ms_download_facts d ON u.user_id = d.user_id
),
paying AS (
    SELECT date, SUM(downloads) AS downloads
    FROM user_downloads
    WHERE paying_customer = 'yes'
    GROUP BY date
),
non_paying AS (
    SELECT date, SUM(downloads) AS downloads
    FROM user_downloads
    WHERE paying_customer = 'no'
    GROUP BY date
)
SELECT
    np.date,
    np.downloads AS non_paying_downloads,
    COALESCE(p.downloads, 0) AS paying_downloads
FROM non_paying np
LEFT JOIN paying p ON np.date = p.date
WHERE np.downloads > p.downloads
OR p.downloads IS NULL
ORDER BY date
;