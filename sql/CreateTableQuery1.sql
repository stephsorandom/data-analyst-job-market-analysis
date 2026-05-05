-- Make sure SSMS is using the correct database
USE job_market_analysis;
GO -- SQL Server syntax for separate batches

-- Create the job_postings table
CREATE TABLE job_postings (
job_id INT PRIMARY KEY,
job_title VARCHAR(150),
company VARCHAR(150),
location VARCHAR(100),
work_type VARCHAR(20),
salary_min INT,
salary_max INT,
experience_required VARCHAR(50),
industry VARCHAR(100),
date_posted DATE
);
GO

-- Create the job_skills table
CREATE TABLE job_skills (
job_id INT,
skill VARCHAR(100),
FOREIGN KEY (job_id) REFERENCES job_postings(job_id)
);
GO