/*
============================================================
PROJECT: Job Market Analysis - Data Ingestion Setup
AUTHOR: Stephanie Mitchell
DESCRIPTION:
Rebuilding tables to support raw CSV ingestion after encountering
multiple data import errors using SSMS Import Wizard.

ISSUES ENCOUNTERED:
- Data type conversion failures (VARCHAR → INT, DATE)
- Truncation errors on text fields (e.g., URL)
- Encoding/code page conflicts (UTF-8 vs 1252)
- Silent insert failures due to strict schema constraints
- Foreign key and primary key dependency conflicts

SOLUTION APPROACH:
- Use flexible data types (VARCHAR) for ingestion layer
- Preserve relational integrity for job_id
- Defer data cleaning and type casting to transformation stage

NOTE:
This is a staging-friendly schema designed for raw data ingestion.
Data will be cleaned and converted in a later step.
============================================================
*/

-- Ensure correct database context
USE job_market_analysis;
GO

/*
============================================================
STEP 1: Drop existing tables
Reason:
- Existing schema was too strict for raw data ingestion
- Required resetting due to type conflicts and failed inserts
- Drop child table first due to foreign key dependency
============================================================
*/

DROP TABLE IF EXISTS job_skills;
DROP TABLE IF EXISTS job_postings;
GO

/*
============================================================
STEP 2: Recreate job_postings (INGESTION-FRIENDLY SCHEMA)

Key Changes:
- salary_min / salary_max → VARCHAR (was INT)
- date_posted → VARCHAR (was DATE)
- Increased VARCHAR lengths to prevent truncation

Reason:
- Raw CSV contains inconsistent formats (nulls, strings, etc.)
- Prevents SSIS/Import Wizard failures during load
- Enables successful bulk ingestion before transformation
============================================================
*/

CREATE TABLE job_postings (
    job_id INT PRIMARY KEY,                -- Kept as INT (used for relationships)
    job_title VARCHAR(255),                -- Increased size to prevent truncation
    company VARCHAR(255),
    location VARCHAR(255),
    work_type VARCHAR(50),
    salary_min VARCHAR(50),                -- Changed from INT → VARCHAR
    salary_max VARCHAR(50),                -- Changed from INT → VARCHAR
    experience_required VARCHAR(50),
    industry VARCHAR(255),
    date_posted VARCHAR(50)                -- Changed from DATE → VARCHAR
);
GO

/*
============================================================
STEP 3: Recreate job_skills (RELATIONAL TABLE)

Notes:
- Maintains foreign key relationship to job_postings
- job_id must remain INT to preserve referential integrity
============================================================
*/

CREATE TABLE job_skills (
    job_id INT,
    skill VARCHAR(100),
    FOREIGN KEY (job_id) REFERENCES job_postings(job_id)
);
GO