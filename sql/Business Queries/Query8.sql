--Query 8: How do skill requirements differ between entry-level (0-1 year) vs early career (2+ year) roles?
	--	Your task: 
--Write a SELECT statement that compares skill requirements across two experience groups:
--	• Group 1: “Entry-Level” (0-1 years) - look for “0-1” or “1+” in experience_required, or “junior” in job_title 
--	• Group 2: “Early Career” (2+ years) - look for “2 years”, “2+”, “2-3”, “2-4”, “3+” in experience_required
--For each skill, show: 
--• How many times it appears in 0-1 year roles 
--• How many times it appears in 2+ year roles 
--• The difference between the two (which shows whether a skill is more important for experienced roles) 
--Only show skills that appear at least 10 times total across both groups. 
--Order by the difference (largest to smallest) to see which skills become more important with experience.


SELECT skill, 
COUNT(CASE WHEN experience_group = 'Entry Level' THEN 1 END) as entry_level, -- conditional aggregation for separate columns
COUNT(CASE WHEN experience_group = 'Early Career' THEN 1 END) as early_career, -- conditional aggregation for separate columns
(
    COUNT(CASE WHEN experience_group = 'Early Career' THEN 1 END)
  - COUNT(CASE WHEN experience_group = 'Entry Level' THEN 1 END)
) AS difference

FROM (SELECT skill,job_title,
CASE
	WHEN LOWER(experience_required) LIKE '%0-1%'
OR LOWER(experience_required) LIKE '%1+%'
OR LOWER(job_title) LIKE '%junior%'
OR LOWER(job_title) LIKE '%jr%' THEN 'Entry Level'
	WHEN LOWER(experience_required) LIKE '%2 years%'
OR LOWER(experience_required) LIKE '%2+%'
OR LOWER(experience_required) LIKE '%2-3%'
OR LOWER(experience_required) LIKE '%2-4%'
OR LOWER(experience_required) LIKE '%0-3%'
OR LOWER(experience_required) LIKE '%3+%' THEN 'Early Career'
END AS experience_group
FROM job_postings_clean as p
JOIN job_skills AS s
ON p.job_id = s.job_id) as t
GROUP BY skill
HAVING COUNT(CASE WHEN experience_group = 'Entry Level' THEN 1 END)
+
COUNT(CASE WHEN experience_group = 'Early Career' THEN 1 END)
>= 10
ORDER BY difference DESC
