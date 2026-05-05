--Query 10: Compare salaries across different tool combinations
--Write a SELECT statement that categorizes jobs into three groups based on their required skills:
--Requirements:
--• Create three groups:
--• “SQL + Excel Only” (has SQL and Excel, but NOT Tableau or Power BI)
--• “SQL + Tableau” (has SQL and Tableau)
--• “SQL + Power BI” (has SQL and Power BI)
--• Show job count and average salary for each group
--• Only include jobs with salary data
--• Order by average salary (highest to lowest)
--Hint: This one is tricky - you’ll need to check if certain skills exist. for a job_id

SELECT
    CASE
        WHEN has_sql = 1 AND has_excel = 1 AND has_tableau = 0 AND has_powerbi = 0
            THEN 'SQL + Excel Only'
        WHEN has_sql = 1 AND has_tableau = 1
            THEN 'SQL + Tableau'
        WHEN has_sql = 1 AND has_powerbi = 1
            THEN 'SQL + Power BI'
         ELSE 'Other SQL Combinations'
    END AS skill_group,
    COUNT(*) AS job_count,
    AVG((salary_min + salary_max) / 2) AS avg_salary

FROM job_postings_clean p
JOIN (SELECT 
    job_id,
    MAX(CASE WHEN skill = 'SQL' THEN 1 ELSE 0 END) AS has_sql,
    MAX(CASE WHEN skill = 'Excel' THEN 1 ELSE 0 END) AS has_excel,
    MAX(CASE WHEN skill = 'Tableau' THEN 1 ELSE 0 END) AS has_tableau,
    MAX(CASE WHEN skill = 'Power BI' THEN 1 ELSE 0 END) AS has_powerbi
FROM job_skills 
GROUP BY job_id) s
ON p.job_id = s.job_id
WHERE p.salary_min IS NOT NULL
  AND p.salary_max IS NOT NULL
  GROUP BY
    CASE
        WHEN has_sql = 1 AND has_excel = 1 AND has_tableau = 0 AND has_powerbi = 0
            THEN 'SQL + Excel Only'
        WHEN has_sql = 1 AND has_tableau = 1
            THEN 'SQL + Tableau'
        WHEN has_sql = 1 AND has_powerbi = 1
            THEN 'SQL + Power BI'
        ELSE 'Other SQL Combinations'
    END
   ORDER BY avg_salary DESC