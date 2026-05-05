-- Query 3: What are the top-paying locations?
	--	Write a SELECT statement that groups jobs by location and calculates average salary for each location. 
	--	Only include locations that have at least 10 job postings AND only include jobs with salary data. 
	--	Show how many jobs are in each location. Order results by average salary (highest to lowest).

--Show location and average salary
--Only include locations with at least 10 job postings (to ensure statistical validity)
--Only include jobs with salary data
--Show how many jobs are in each location
--Order by average salary (highest to lowest)

--Midpoint Formula (which gives a single total for EACH row 
--(salary_min + salary_max) / 2


SELECT location, COUNT(location) as number_of_jobs_per_location, AVG( (salary_min + salary_max) / 2 ) as avg_salary_per_location
FROM job_postings_clean
WHERE salary_min IS NOT NULL
	AND salary_max IS NOT NULL
GROUP BY location
HAVING COUNT(location) >= 2 -- Had to change from at least 10, to at least 2 to get some results
ORDER BY avg_salary_per_location DESC;