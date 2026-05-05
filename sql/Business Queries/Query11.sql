--Query 11 (BONUS): Which industries value which skills most? (Industry × Skill Matrix)
--Your task:
--Create a matrix showing what percentage of jobs in each industry require each of the top skills.
--First, identify:
--	•	The top 5 most common industries (by job count)
--	•	The top 8 most common skills overall
--Then, for each industry-skill combination, calculate what percentage of jobs in that industry require that skill.

--Hint: This is a complex query. You’ll likely need:
--	1.	A CTE or subquery to identify the top 5 industries
--	2.	A CTE or subquery to identify the top 8 skills
--	3.	Conditional aggregation to calculate percentages for each industry-skill combo
--	4.	PIVOT logic or multiple CASE statements to create the matrix format

-- top 5 industries
WITH top_industries AS (
    SELECT industry
    FROM job_postings_clean
    WHERE industry IS NOT NULL
    GROUP BY industry
    ORDER BY COUNT(*) DESC
    OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY
)

-- top 8 skills
, top_skills AS (
    SELECT skill
    FROM job_skills
    GROUP BY skill
    ORDER BY COUNT(*) DESC
    OFFSET 0 ROWS FETCH NEXT 8 ROWS ONLY
)

-- Joining together industry + skill + jobs
, industry_skill AS (
    SELECT 
        p.industry,
        s.skill,
        p.job_id
    FROM job_postings_clean p
    JOIN job_skills s ON p.job_id = s.job_id
    JOIN top_industries ti ON p.industry = ti.industry
    JOIN top_skills ts ON s.skill = ts.skill
)


-- Job count per industry
industry_totals AS (
    SELECT industry, COUNT(DISTINCT job_id) AS total_jobs
    FROM industry_skill
    GROUP BY industry
)


-- Job count per indstry and skill
industry_totals AS (
    SELECT industry, COUNT(DISTINCT job_id) AS total_jobs
    FROM industry_skill
    GROUP BY industry
)

-- calculate percentage
SELECT 
    isc.industry,
    isc.skill,
    CAST(isc.jobs_with_skill * 1.0 / it.total_jobs AS DECIMAL(5,2)) AS pct
FROM industry_skill_counts isc
JOIN industry_totals it 
    ON isc.industry = it.industry
ORDER BY isc.industry, isc.skill;


-- pivot 
PIVOT (
    MAX(pct)
    FOR skill IN ([SQL], [Excel], [Python], [Tableau], [Power BI], …)
) AS p


-- Top 5 industries and top 8 skills → Industry × Skill Matrix
WITH top_industries AS (
    SELECT industry
    FROM job_postings_clean
    WHERE industry IS NOT NULL
    GROUP BY industry
    ORDER BY COUNT(*) DESC
    OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY
),

top_skills AS (
    SELECT skill
    FROM job_skills
    GROUP BY skill
    ORDER BY COUNT(*) DESC
    OFFSET 0 ROWS FETCH NEXT 8 ROWS ONLY
),

industry_skill AS (
    SELECT 
        p.industry,
        s.skill,
        p.job_id
    FROM job_postings_clean p
    JOIN job_skills s ON p.job_id = s.job_id
    JOIN top_industries ti ON p.industry = ti.industry
    JOIN top_skills ts ON s.skill = ts.skill
),

industry_totals AS (
    SELECT 
        industry,
        COUNT(DISTINCT job_id) AS total_jobs
    FROM industry_skill
    GROUP BY industry
),

industry_skill_counts AS (
    SELECT 
        industry,
        skill,
        COUNT(DISTINCT job_id) AS jobs_with_skill
    FROM industry_skill
    GROUP BY industry, skill
)

SELECT 
    isc.industry,
    isc.skill,
    CAST(isc.jobs_with_skill * 1.0 / it.total_jobs AS DECIMAL(5,2)) AS pct_of_jobs
FROM industry_skill_counts isc
JOIN industry_totals it 
    ON isc.industry = it.industry
ORDER BY isc.industry, isc.skill;
