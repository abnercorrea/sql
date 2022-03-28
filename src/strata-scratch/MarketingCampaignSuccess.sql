-- https://platform.stratascratch.com/coding/514-marketing-campaign-success-advanced
-- You have a table of in-app purchases by user.
-- Users that make their first in-app purchase are placed in a marketing campaign where they see call-to-actions for more in-app purchases.
-- Find the number of users that made additional in-app purchases due to the success of the marketing campaign.

-- The marketing campaign doesn't start until one day after the initial in-app purchase so users that make multiple purchases on the same day do not count,
-- nor do we count users that make only the same purchases over time.

WITH first_purchase AS (
    SELECT
        *,
        FIRST_VALUE(created_at) OVER w AS first_purchase_date
    FROM marketing_campaign
    WINDOW w AS (PARTITION BY user_id ORDER BY created_at)
)
SELECT COUNT(DISTINCT user_id)
FROM first_purchase fp
WHERE created_at > first_purchase_date
AND NOT EXISTS (
    SELECT 'repeated'
    FROM marketing_campaign p
    WHERE p.user_id = fp.user_id
    AND p.product_id = fp.product_id
    AND p.created_at < fp.created_at
)
;
