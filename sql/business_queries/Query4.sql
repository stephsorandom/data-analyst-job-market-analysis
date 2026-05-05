--Query 4: Which skills pay the most?

--Your task:
--Write a SELECT statement that JOINs job_postings_clean and job_skills tables to find average salary for each skill. 
--Only include skills that appear in at least 10 jobs AND only include jobs with salary data.
--Show top 10 skills ordered by average salary (highest to lowest).

--Show skill name and average salary for jobs requiring that skill
--Only include skills that appear in at least 10 jobs (to ensure statistical validity)
--Only include jobs with salary data
--You’ll need to JOIN the job_postings_clean and job_skills tables
--Order by average salary (highest to lowest)
--Show top 10 only

SELECT s.skill, COUNT(s.job_id) as skill_count, AVG((salary_min + salary_max) / 2) as avg_salary -- Counting how many skills and the avg salary midpoint formula
FROM job_postings_clean as p
JOIN job_skills as s
ON p.job_id = s.job_id
WHERE salary_min IS NOT NULL
	AND salary_max IS NOT NULL
GROUP BY s.skill
HAVING COUNT(s.job_id) >= 10 -- limiting only to skill_counts to a minimum of 10 counts.
ORDER BY avg_salary DESC;

