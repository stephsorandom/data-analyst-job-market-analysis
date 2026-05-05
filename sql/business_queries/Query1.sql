-- Query 1: What are the top 10 most in-demand skills?	
	--Show skill name
	--Show how many jobs require each skill
	--Show what percentage of all jobs this represents (part / whole) * 100
	--Order from most to least common


--1.  SELECT skill, COUNT(*) AS frequency
--    FROM job_skills
--    GROUP BY skill


--2.(frequency * 100.0 / SUM(frequency) OVER()) AS percentage


-- 3. Combined Query into Window Function
SELECT TOP 10 
    skill, frequency,(frequency * 100.0 / SUM(frequency) OVER()) AS percentage
FROM (
    SELECT skill, COUNT(*) AS frequency
    FROM job_skills
    GROUP BY skill
) AS t
ORDER BY frequency DESC;
