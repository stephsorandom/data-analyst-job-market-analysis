--Query 5: What skill pairs appear together most frequently?
-- Write a SELECT statement that joins the job_skills table to ITSELF to find pairs of skills that appear in the same job posting. 
-- Make sure you don’t count duplicates (SQL+Python and Python+SQL should only count once) and don’t pair a skill with itself (SQL+SQL shouldn’t appear).
-- Show the top 15 pairs ordered by how many times they appear together.

--• Find pairs of skills that appear in the same job posting
--• Don’t count duplicates (SQL+Python should only appear once, not also as Python+SQL)
--• Don’t pair a skill with itself
--• Show how many times each pair appears
--• Show what percentage of all jobs have this combination
--• Only show pairs that appear at least 15 times
--• Order by frequency (most common first)
--• Show top 15 pairs

SELECT TOP 15 s.skill as skill1, ss.skill as skill2, COUNT(s.job_id) AS skill_pairs, -- selecting both sides of the skill 1&2
(COUNT(s.job_id) * 1.0 / (SELECT COUNT(*) FROM job_postings_clean)) AS pct_of_jobs -- getting the count of pairs & percentage of the pairs
FROM job_skills as s
JOIN job_skills as ss
ON s.job_id = ss.job_id
WHERE s.skill != ss.skill -- I could also use: ( s.skill <> ss.skill )
	AND s.skill < ss.skill -- Ensuring we use s (skill1) as the base alphabetically when pairing happens
GROUP BY s.skill, ss.skill
HAVING COUNT(s.job_id) >= 15 -- All skills pairs must be at least 15 or more
ORDER BY skill_pairs DESC;
