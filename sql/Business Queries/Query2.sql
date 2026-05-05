-- Query 2: How does experience level affect salary?
	--Group by experience_required
	--Show count of jobs for each experience level
	--Show average minimum salary, average maximum salary, and average midpoint salary
	--Only include jobs that have salary data
	--Order by average salary (highest to lowest)

--Write a SELECT statement that groups jobs by experience level and calculates:
	--How many jobs are at each experience level
	SELECT experience_required, COUNT(experience_required) as experience_counts FROM job_postings_clean GROUP BY experience_required ORDER BY COUNT(experience_required) DESC; 
	--The average minimum salary for that level
	SELECT experience_required, CAST(AVG(salary_min) as INT) FROM job_postings_clean GROUP BY experience_required
	--The average maximum salary for that level
	SELECT experience_required, CAST(AVG(salary_max) as INT) FROM job_postings_clean GROUP BY experience_required
	--The average midpoint salary (average of min and max)
	--Only include jobs that have salary data. Order results by average midpoint salary (highest to lowest).
	SELECT AVG(salary_min), AVG(salary_max) FROM job_postings_clean HAVING AVG(salary_min) & AVG(salary_max) IS NOT NULL ORDER BY AVG(mid_point)

SELECT
    experience_required,
    COUNT(*) AS job_count, -- Using COUNT(*) because we want the count including any NULLs
    AVG(salary_min) AS avg_min_salary,
    AVG(salary_max) AS avg_max_salary,
    AVG((salary_min + salary_max) / 2) AS avg_mid_salary --business logic math to find midpoint
FROM job_postings_clean
WHERE salary_min IS NOT NULL
  AND salary_max IS NOT NULL
GROUP BY experience_required
ORDER BY avg_mid_salary DESC;


