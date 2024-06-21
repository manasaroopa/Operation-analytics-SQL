use jb_analysis;

select EXTRACT(WEEK FROM occurred_at) AS "week number" , 
count(distinct user_id) as "active users"
from events
where event_type = 'engagement'
group by 1;



select months, users, ROUND(((users/LAG(users,1) OVER
(ORDER BY months)-1) * 100),2) as "growth in %" from
(select extract(month from created_at) as months,
count(activated_at) as users from users 
where activated_at is not null
group by 1 order by 1) sub;
