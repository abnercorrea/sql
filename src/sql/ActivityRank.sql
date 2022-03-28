WITH user_email AS (
    select
        from_user AS user_name,
        COUNT(*) AS total_emails
    from google_gmail_emails
    GROUP BY from_user
)
SELECT
    user_name,
    total_emails,
    RANK() OVER (ORDER BY total_emails DESC, user_name) AS activity_rank
FROM user_email
ORDER BY total_emails DESC, user_name
;