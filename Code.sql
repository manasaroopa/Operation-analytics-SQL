use jb_analysis;

select ds as dates, round(3600/sum(time_spent)*count(ds))
as jobs_reviewed_per_hour
from job_data
group by ds;



SELECT 
COUNT(event) / SUM(time_spent)
FROM
job_data;

SELECT 
    language,
    COUNT(language) * 100 / (SELECT 
            COUNT(*)
        FROM
            job_data)
FROM
    job_data
GROUP BY language;



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
