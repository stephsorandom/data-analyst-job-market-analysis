--Query 7: What skills are most common in remote jobs specifically?
--	Your task:
--Write a SELECT statement that filters to ONLY remote jobs, then shows which skills appear most frequently in those remote positions. 
--Calculate what percentage of remote jobs require each skill.
--Show top 10 skills ordered by frequency (most to least common).

--• Filter to only Remote jobs
--• Show skill name and how many remote jobs require it
--• Show what percentage of remote jobs require this skill
--• Order by frequency (most to least common)
--• Show top 10 only


SELECT TOP 10 s.skill, COUNT(DISTINCT p.job_id) as skill_count, ( COUNT(DISTINCT p.job_id) * 1.0 /
	(SELECT COUNT(job_id) FROM job_postings_clean WHERE work_type = 'Remote')) skill_count_percentage
FROM job_postings_clean as p
JOIN job_skills as s
ON p.job_id = s.job_id
WHERE p.work_type = 'Remote'
GROUP BY s.skill
ORDER BY skill_count DESC;