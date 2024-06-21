use jb_analysis;

select ds as dates, round(3600/sum(time_spent)*count(ds))
as jobs_reviewed_per_hour
from job_data
group by ds;



SELECT ds as date, count(ds)/sum(time_spent)
from job_data
group by ds;

select
COUNT(event) / SUM(time_spent)
FROM
job_data;



SELECT language,
COUNT(language) * 100 / (SELECT COUNT(*) FROM job_data)
FROM job_data
GROUP BY language;


SELECT actor_id, 
count(actor_id) as duplicate rows
from job data
group by actor_id
having count(actor_id) > 1




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


select first as "week number",
sum(case when week_number=0 then 1 else 0 end) as "week 0",
sum(case when week_number=1 then 1 else 0 end) as "week 1",
sum(case when week_number=2 then 1 else 0 end) as "week 2",
sum(case when week_number=3 then 1 else 0 end) as "week 3",
sum(case when week_number=4 then 1 else 0 end) as "week 4",
sum(case when week_number=5 then 1 else 0 end) as "week 5",
sum(case when week_number=6 then 1 else 0 end) as "week 6",
sum(case when week_number=7 then 1 else 0 end) as "week 7",
sum(case when week_number=8 then 1 else 0 end) as "week 8",
sum(case when week_number=9 then 1 else 0 end) as "week 9",
sum(case when week_number=10 then 1 else 0 end) as "week 10",
sum(case when week_number=11 then 1 else 0 end) as "week 11",
sum(case when week_number=12 then 1 else 0 end) as "week 12",
sum(case when week_number=13 then 1 else 0 end) as "week 13",
sum(case when week_number=14 then 1 else 0 end) as "week 14",
sum(case when week_number=15 then 1 else 0 end) as "week 15",
sum(case when week_number=16 then 1 else 0 end) as "week 16",
sum(case when week_number=17 then 1 else 0 end) as "week 17",
sum(case when week_number=18 then 1 else 0 end) as "week 18"
from
(select a.user_id, a.login_week, b.first, a.login_week - first as week_number
from
(select user_id, EXTRACT(week from occurred_at) as login_week from events
group by 1,2) a,
(select user_id, min(extract(week from occurred_at)) as first from events
group by 1) b
where a.user_id = b.user_id)
sq
group by first
order by first;



select week,
round((weekly_digest/total*100),2) as "weekly digest rate",
round((email_opens/total*100),2) as "email open rate",
round((email_clickthroughs/total*100),2) as "email click",
round((reengagement_emails/total*100),2) as "reengagement"
from
(select extract(week from occurred_at) as week,
count(case when action='sent_weekly_digest' then user_id else null end) as weekly_digest,
count(case when action='email_open' then user_id else null end) as email_opens,
count(case when action='email_clickthrough' then user_id else null end) as email_clickthroughs,
count(case when action='sent_reengagement_email' then user_id else null end) as reengagement_emails,
count(user_id) as total
from email_events
group by 1) sq
group by 1 order by 1;


