--Query 9: Which industries are hiring the most and how do they pay?
--Your task:
--Write a SELECT statement that groups jobs by industry and shows both the job count and average salary
--for each industry. Only include industries with at least 5 jobs. Order by job count (most jobs first).
--Requirements:
--• Group by industry
--• Show job count and average salary for each industry
--• Only include industries with at least 5 jobs
--• Order by job count (most jobs first)


SELECT industry,COUNT(*) AS job_count, AVG((salary_min + salary_max) / 2) as avg_salary
FROM job_postings_clean
GROUP BY industry
HAVING COUNT(*) >= 3
ORDER BY job_count DESC;
