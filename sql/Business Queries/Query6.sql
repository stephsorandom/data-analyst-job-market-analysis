--	Query 6: Do Python jobs pay more than non-Python jobs?
--Write a SELECT statement that creates two groups: jobs that require Python and jobs that don’t require Python.
--Calculate the count and average salary for each group. Only include jobs with salary data.
--Hint : You’ll need to use a CASE statement or subquery to categorize jobs into these two groups.

--Case Statement Syntax:
--CASE 
--    WHEN <condition> THEN <value_if_true>
--    WHEN <another_condition> THEN <another_value>
--    ELSE <value_if_none_match>
--END AS <alias_name>

--• Create two groups: “Requires Python” and “No Python Required”
--• Show count of jobs in each group
--• Show average salary for each group
--• Only include jobs with salary data
--• Compare the difference


--My query where I got stuck

--SELECT COUNT(DISTINCT p.job_id) AS job_count,
--    AVG((p.salary_min + p.salary_max) / 2.0) AS avg_salary,
--    CASE 
--        WHEN s.skill = 'Python' THEN 'Python Required'
--        ELSE 'No Python Required'
--    END AS python_group
--FROM job_postings_clean AS p
--JOIN job_skills AS s
--    ON p.job_id = s.job_id
--WHERE p.salary_min IS NOT NULL
--  AND p.salary_max IS NOT NULL;

-- Compare salaries between jobs requiring Python vs not requiring Python
WITH JobCategories AS (
    SELECT 
        job_id,
        salary_min,
        salary_max,
        CASE 
            WHEN job_id IN (SELECT job_id FROM job_skills WHERE skill = 'Python') 
            THEN 'Python Required'
            ELSE 'No Python Required'
        END AS python_requirement
    FROM job_postings_clean
    WHERE salary_min IS NOT NULL
)
SELECT 
    python_requirement,
    COUNT(*) AS num_jobs,
    AVG((salary_min + salary_max) / 2.0) AS avg_salary
FROM JobCategories
GROUP BY python_requirement;



  