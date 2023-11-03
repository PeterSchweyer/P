create database if not exists project_sql;

select school
from project_sql.schools;

select *
from project_sql.comments;

select * 
from project_sql.locations;

select * 
from project_sql.courses;

select * 
from project_sql.badges;

/*What school have locations in Germany, Portugal*/

select schools.school, GROUP_CONCAT(city_name SEPARATOR ', ') as Locations
from project_sql.schools
inner join project_sql.locations
on project_sql.schools.school_id = project_sql.locations.school_id
where country_name = "Germany" or country_name = "Portugal"
group by schools.school; 

/*What school hast the best comments and how many*/

select project_sql.schools.school, round(avg(overall_score), 2) as average_score, count(overall_score) as number_comments
from project_sql.comments
inner join project_sql.schools
on project_sql.comments.school = project_sql.schools.school
group by school
order by average_score desc;

/*List top 3 schools based on number of locations*/

select project_sql.schools.school, count(project_sql.locations.country_name) as number_locations
from project_sql.schools
inner join project_sql.locations
on project_sql.schools.school = project_sql.locations.school
group by school
order by number_locations desc
limit 3;

/*What schools have data analytics as a course which are the best*/

SELECT f.courses, comments.school, round(avg(comments.overall), 2) as overall_rating
FROM project_sql.comments 
INNER JOIN (
			SELECT l.school, co.courses
			FROM project_sql.locations AS l
			INNER JOIN (
						SELECT courses, school
						FROM project_sql.courses
						WHERE courses LIKE "%Data Analytics Bootcamp%" OR courses LIKE "%Data Science%") AS co
			ON l.school = co.school) AS f
ON comments.school = f.school
GROUP BY f.courses, comments.school
ORDER BY overall_rating DESC;



/*How many comments has each school only in 2023*/

select project_sql.schools.school, count(overall_score) as number_comments, graduating_year
from project_sql.comments
inner join project_sql.schools
on project_sql.comments.school = project_sql.schools.school
where graduating_year = "2023"
group by school
order by number_comments desc;

/**/

