with user_friends as (
    select a user_id, count(*) friends from
    (
        select user1 a, user2 b from facebook_friends
        union
        select user2 a, user1 b from facebook_friends
    ) f
    group by user_id
)
select user_id, (friends / (select count(*) from user_friends)::float) * 100 popularity 
from user_friends
order by user_id
;