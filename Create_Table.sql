CREATE TABLE events(
user_id int,
occurred_at varchar(100),
event_type varchar(50),
event_name varchar(100),
location varchar(50),
device varchar(50),
user_type int);

-- adding data from source data file
load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/events.csv"
into table events
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

alter table events add column temp_occurred_at datetime;
update events set temp_occurred_at = str_to_date(occurred_at, '%d-%m-%Y %H:%i');
alter table events drop column occurred_at;
alter table events change column temp_occurred_at occurred_at datetime;



CREATE TABLE users(
	user_id INT,
	created_at TIMESTAMP,
	company_id INT,
	language VARCHAR(100),
	activated_at TIMESTAMP,
	state VARCHAR(50)
	);


COPY users 
FROM 'D:\Operational-Analytics-Study\src\data\users.csv'
WITH (FORMAT CSV, HEADER);


CREATE TABLE email_events(
	user_id INT,
	occured_at TIMESTAMP,
	action VARCHAR(100),
	user_type INT
	
	);

--Adding Data in users table

COPY email_events 
FROM 'D:\Operational-Analytics-Study\src\data\email_events.csv'
WITH (FORMAT CSV, HEADER);


CREATE TABLE job_data(
	ds DATE,
	job_id INT,
	actor_id INT,
	event VARCHAR(30),
	language VARCHAR(30),
	time_spent INT,
	org VARCHAR(30)
	
	);
SET datestyle = 'ISO, MDY';
--Adding Data in users table

COPY job_data 
FROM 'D:\Operational-Analytics-Study\src\data\job_data.csv'
WITH (FORMAT CSV, HEADER);

--Checking for users table
SELECT * FROM job_data ;
