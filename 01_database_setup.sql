
-- =====================================================
-- PROJECT: AI/ML JOB MARKET & SKILL GAP ANALYTICS
-- MYSQL 8.0+
-- STEP 1: DATABASE + TABLES
-- =====================================================

DROP DATABASE IF EXISTS ai_ml_job_market;
CREATE DATABASE ai_ml_job_market;
USE ai_ml_job_market;

CREATE TABLE companies (
    company_id INT PRIMARY KEY AUTO_INCREMENT,
    company_name VARCHAR(150) NOT NULL,
    industry VARCHAR(100),
    company_size VARCHAR(50)
);

CREATE TABLE locations (
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100),
    country VARCHAR(100) DEFAULT 'India'
);

CREATE TABLE skills (
    skill_id INT PRIMARY KEY AUTO_INCREMENT,
    skill_name VARCHAR(100) NOT NULL UNIQUE,
    skill_category VARCHAR(100)
);

CREATE TABLE jobs (
    job_id INT PRIMARY KEY AUTO_INCREMENT,
    company_id INT NOT NULL,
    location_id INT NOT NULL,
    job_title VARCHAR(150) NOT NULL,
    experience_min INT,
    experience_max INT,
    salary_min DECIMAL(12,2),
    salary_max DECIMAL(12,2),
    work_mode VARCHAR(30),
    posted_date DATE,
    FOREIGN KEY (company_id) REFERENCES companies(company_id),
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE job_skills (
    job_id INT NOT NULL,
    skill_id INT NOT NULL,
    required_level VARCHAR(30),
    PRIMARY KEY (job_id, skill_id),
    FOREIGN KEY (job_id) REFERENCES jobs(job_id)
        ON DELETE CASCADE,
    FOREIGN KEY (skill_id) REFERENCES skills(skill_id)
        ON DELETE CASCADE
);

CREATE TABLE job_postings (
    posting_id INT PRIMARY KEY AUTO_INCREMENT,
    job_id INT NOT NULL,
    source VARCHAR(100),
    posting_date DATE,
    application_count INT DEFAULT 0,
    status VARCHAR(30),
    FOREIGN KEY (job_id) REFERENCES jobs(job_id)
        ON DELETE CASCADE
);

-- =====================================================
-- STEP 2: INSERT 25 COMPANIES
-- =====================================================

INSERT INTO companies (company_name, industry, company_size)
VALUES
('Tata Consultancy Services','IT Services','Large'),
('Infosys','IT Services','Large'),
('Accenture','Consulting','Large'),
('Deloitte','Consulting','Large'),
('Capgemini','IT Services','Large'),
('Cognizant','IT Services','Large'),
('Wipro','IT Services','Large'),
('HCLTech','IT Services','Large'),
('IBM','Technology','Large'),
('Microsoft','Technology','Large'),
('Amazon','Technology','Large'),
('Google','Technology','Large'),
('Fractal Analytics','Analytics','Large'),
('Tiger Analytics','Analytics','Large'),
('Mu Sigma','Analytics','Large'),
('Zensar Technologies','IT Services','Large'),
('Persistent Systems','IT Services','Large'),
('LTIMindtree','IT Services','Large'),
('Freshworks','Software','Medium'),
('PhonePe','FinTech','Large'),
('Razorpay','FinTech','Medium'),
('Swiggy','E-commerce','Large'),
('Zomato','E-commerce','Large'),
('Myntra','E-commerce','Large'),
('Jio Platforms','Technology','Large');

-- =====================================================
-- STEP 3: INSERT 15 LOCATIONS
-- =====================================================

INSERT INTO locations (city, state, country)
VALUES
('Mumbai','Maharashtra','India'),
('Pune','Maharashtra','India'),
('Bengaluru','Karnataka','India'),
('Hyderabad','Telangana','India'),
('Chennai','Tamil Nadu','India'),
('New Delhi','Delhi','India'),
('Gurugram','Haryana','India'),
('Noida','Uttar Pradesh','India'),
('Kolkata','West Bengal','India'),
('Ahmedabad','Gujarat','India'),
('Navi Mumbai','Maharashtra','India'),
('Thane','Maharashtra','India'),
('Jaipur','Rajasthan','India'),
('Indore','Madhya Pradesh','India'),
('Kochi','Kerala','India');

-- =====================================================
-- STEP 4: INSERT 41 SKILLS
-- =====================================================

INSERT INTO skills (skill_name, skill_category)
VALUES
('Python','Programming'),
('R','Programming'),
('Java','Programming'),
('C++','Programming'),
('SQL','Database'),
('MySQL','Database'),
('PostgreSQL','Database'),
('MongoDB','Database'),
('Excel','Analytics'),
('Power Query','Analytics'),
('Pandas','Python Library'),
('NumPy','Python Library'),
('Matplotlib','Visualization'),
('Power BI','Visualization'),
('Tableau','Visualization'),
('Machine Learning','AI/ML'),
('Deep Learning','AI/ML'),
('TensorFlow','AI/ML'),
('PyTorch','AI/ML'),
('Scikit-learn','AI/ML'),
('Natural Language Processing','AI/ML'),
('Computer Vision','AI/ML'),
('Statistics','Analytics'),
('Regression','Analytics'),
('Hypothesis Testing','Analytics'),
('AWS','Cloud'),
('Microsoft Azure','Cloud'),
('Google Cloud','Cloud'),
('Apache Spark','Big Data'),
('Hadoop','Big Data'),
('ETL','Data Engineering'),
('Data Warehousing','Data Engineering'),
('Airflow','Data Engineering'),
('Git','Development Tools'),
('GitHub','Development Tools'),
('Docker','Development Tools'),
('Generative AI','AI/ML'),
('Large Language Models','AI/ML'),
('Prompt Engineering','AI/ML'),
('Data Visualization','Visualization'),
('dbt','Data Engineering');

-- =====================================================
-- STEP 5A: GENERATE 100 JOB RECORDS
-- Salary values are annual INR; 700000 = ₹7 LPA
-- =====================================================

INSERT INTO jobs
(company_id, location_id, job_title, experience_min,
 experience_max, salary_min, salary_max, work_mode, posted_date)

SELECT
    MOD(n - 1, 25) + 1,
    MOD(n - 1, 15) + 1,

    CASE MOD(n - 1, 20)
        WHEN 0 THEN 'Data Analyst'
        WHEN 1 THEN 'Senior Data Analyst'
        WHEN 2 THEN 'Product Data Analyst'
        WHEN 3 THEN 'Data Scientist'
        WHEN 4 THEN 'Senior Data Scientist'
        WHEN 5 THEN 'Machine Learning Engineer'
        WHEN 6 THEN 'ML Engineer'
        WHEN 7 THEN 'Senior ML Engineer'
        WHEN 8 THEN 'AI/ML Engineer'
        WHEN 9 THEN 'AI Engineer'
        WHEN 10 THEN 'AI Research Engineer'
        WHEN 11 THEN 'AI Research Scientist'
        WHEN 12 THEN 'Business Intelligence Analyst'
        WHEN 13 THEN 'Senior BI Analyst'
        WHEN 14 THEN 'BI Developer'
        WHEN 15 THEN 'Power BI Developer'
        WHEN 16 THEN 'Business Analyst'
        WHEN 17 THEN 'Data Engineer'
        WHEN 18 THEN 'Product Analyst'
        ELSE 'Analytics Engineer'
    END,

    CASE
        WHEN MOD(n - 1, 20) IN (1,4,7,11,13) THEN 4
        WHEN MOD(n - 1, 20) IN (5,6,8,9,10,17,19) THEN 2
        ELSE 0
    END,

    CASE
        WHEN MOD(n - 1, 20) IN (1,4,7,11,13) THEN 8
        WHEN MOD(n - 1, 20) IN (5,6,8,9,10,17,19) THEN 5
        ELSE 3
    END,

    CASE
        WHEN MOD(n - 1, 20) IN (1,4,7,11,13) THEN 1000000
        WHEN MOD(n - 1, 20) IN (5,6,8,9,10,17,19) THEN 700000
        ELSE 400000
    END,

    CASE
        WHEN MOD(n - 1, 20) IN (1,4,7,11,13) THEN 2200000
        WHEN MOD(n - 1, 20) IN (5,6,8,9,10,17,19) THEN 1800000
        ELSE 1000000
    END,

    CASE MOD(n, 3)
        WHEN 0 THEN 'Remote'
        WHEN 1 THEN 'Hybrid'
        ELSE 'Onsite'
    END,

    DATE_ADD('2026-01-05', INTERVAL (n - 1) * 3 DAY)

FROM (
    SELECT
        ones.d + tens.d * 10 + 1 AS n
    FROM
        (SELECT 0 d UNION ALL SELECT 1 UNION ALL SELECT 2
         UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL
         SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7
         UNION ALL SELECT 8 UNION ALL SELECT 9) ones
    CROSS JOIN
        (SELECT 0 d UNION ALL SELECT 1 UNION ALL SELECT 2
         UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL
         SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7
         UNION ALL SELECT 8 UNION ALL SELECT 9) tens
) numbers
WHERE n <= 100;

-- =====================================================
-- STEP 5B: MAP JOBS TO REQUIRED SKILLS
-- Each job receives multiple skills based on its title.
-- =====================================================

INSERT INTO job_skills (job_id, skill_id, required_level)
SELECT DISTINCT
    j.job_id,
    s.skill_id,
    CASE
        WHEN s.skill_name IN
        ('Machine Learning','Deep Learning','TensorFlow',
         'PyTorch','AWS','Microsoft Azure','Google Cloud',
         'Apache Spark','Generative AI','Large Language Models')
        THEN 'Advanced'
        ELSE 'Intermediate'
    END
FROM jobs j
JOIN skills s
ON
(
    (
        j.job_title LIKE '%Data Analyst%'
        AND s.skill_name IN
        ('SQL','Python','Excel','Power BI','Statistics',
         'Pandas','NumPy','Matplotlib','Git','Data Visualization')
    )
    OR
    (
        j.job_title LIKE '%Data Scientist%'
        AND s.skill_name IN
        ('Python','SQL','Machine Learning','Statistics',
         'Pandas','NumPy','Scikit-learn','Regression',
         'Power BI','Git')
    )
    OR
    (
        (j.job_title LIKE '%ML Engineer%'
         OR j.job_title LIKE '%Machine Learning Engineer%'
         OR j.job_title LIKE '%AI/ML Engineer%')
        AND s.skill_name IN
        ('Python','SQL','Machine Learning','Deep Learning',
         'TensorFlow','PyTorch','Scikit-learn','Git',
         'Docker','AWS')
    )
    OR
    (
        j.job_title LIKE '%AI Engineer%'
        AND s.skill_name IN
        ('Python','SQL','Machine Learning','Deep Learning',
         'TensorFlow','PyTorch','Natural Language Processing',
         'Generative AI','Large Language Models',
         'Git','Docker','AWS')
    )
    OR
    (
        j.job_title LIKE '%AI Research%'
        AND s.skill_name IN
        ('Python','Machine Learning','Deep Learning',
         'TensorFlow','PyTorch','Natural Language Processing',
         'Computer Vision','Statistics','Generative AI',
         'Large Language Models')
    )
    OR
    (
        j.job_title LIKE '%Data Engineer%'
        AND s.skill_name IN
        ('Python','SQL','MySQL','PostgreSQL','Apache Spark',
         'Hadoop','ETL','Data Warehousing','Airflow',
         'AWS','Docker','Git','dbt')
    )
    OR
    (
        (j.job_title LIKE '%BI Analyst%'
         OR j.job_title LIKE '%Business Intelligence Analyst%'
         OR j.job_title LIKE '%BI Developer%'
         OR j.job_title LIKE '%Power BI Developer%')
        AND s.skill_name IN
        ('SQL','Excel','Power BI','Tableau','Power Query',
         'Statistics','Git','Data Visualization')
    )
    OR
    (
        (j.job_title LIKE '%Business Analyst%'
         OR j.job_title LIKE '%Product Analyst%')
        AND s.skill_name IN
        ('SQL','Excel','Power BI','Tableau','Statistics',
         'Python','Power Query','Data Visualization')
    )
    OR
    (
        j.job_title LIKE '%Analytics Engineer%'
        AND s.skill_name IN
        ('SQL','Python','MySQL','PostgreSQL','ETL',
         'Data Warehousing','Airflow','dbt','Git','AWS')
    )
);

-- =====================================================
-- STEP 5C: ADD POSTING DETAILS FOR ALL 100 JOBS
-- Sources and application counts are synthetic.
-- =====================================================

INSERT INTO job_postings
(job_id, source, posting_date, application_count, status)
SELECT
    j.job_id,
    CASE MOD(j.job_id, 4)
        WHEN 1 THEN 'LinkedIn'
        WHEN 2 THEN 'Naukri'
        WHEN 3 THEN 'Indeed'
        ELSE 'Company Website'
    END,
    j.posted_date,
    50 + MOD(j.job_id * 13, 151),
    CASE
        WHEN MOD(j.job_id, 3) = 0 THEN 'Closed'
        ELSE 'Active'
    END
FROM jobs j;

-- =====================================================
-- STEP 6: VERIFY ALL TABLES
-- =====================================================

SELECT 'companies' AS table_name, COUNT(*) AS total_rows
FROM companies
UNION ALL
SELECT 'locations', COUNT(*) FROM locations
UNION ALL
SELECT 'skills', COUNT(*) FROM skills
UNION ALL
SELECT 'jobs', COUNT(*) FROM jobs
UNION ALL
SELECT 'job_skills', COUNT(*) FROM job_skills
UNION ALL
SELECT 'job_postings', COUNT(*) FROM job_postings;

USE ai_ml_job_market;

SELECT * FROM jobs;

-- Companies dataset
SELECT * FROM companies;

-- Locations dataset
SELECT * FROM locations;

-- Skills dataset
SELECT * FROM skills;

-- Jobs dataset
SELECT * FROM jobs;

-- Job skills dataset
SELECT * FROM job_skills;

-- Job postings dataset
SELECT * FROM job_postings;


SELECT
    j.job_id,
    c.company_name,
    j.job_title,
    l.city,
    j.experience_min,
    j.experience_max,
    j.salary_min,
    j.salary_max,
    j.work_mode,
    s.skill_name,
    js.required_level,
    jp.source,
    jp.application_count,
    jp.status
FROM jobs j
JOIN companies c
    ON j.company_id = c.company_id
JOIN locations l
    ON j.location_id = l.location_id
LEFT JOIN job_skills js
    ON j.job_id = js.job_id
LEFT JOIN skills s
    ON js.skill_id = s.skill_id
LEFT JOIN job_postings jp
    ON j.job_id = jp.job_id
ORDER BY j.job_id, s.skill_name;



USE ai_ml_job_market;

-- 1. Total jobs
SELECT COUNT(*) AS total_jobs FROM jobs;

-- 2. Total companies
SELECT COUNT(*) AS total_companies FROM companies;

-- 3. Total skills in database
SELECT COUNT(*) AS total_skills FROM skills;

-- 4. Jobs by job title
SELECT job_title, COUNT(*) AS job_count
FROM jobs
GROUP BY job_title
ORDER BY job_count DESC;

-- 5. Jobs by work mode
SELECT work_mode, COUNT(*) AS total_jobs
FROM jobs
GROUP BY work_mode
ORDER BY total_jobs DESC;

-- 6. Jobs by city
SELECT l.city, COUNT(*) AS total_jobs
FROM jobs j
JOIN locations l ON j.location_id = l.location_id
GROUP BY l.city
ORDER BY total_jobs DESC;

-- 7. Jobs by company
SELECT c.company_name, COUNT(*) AS total_jobs
FROM jobs j
JOIN companies c ON j.company_id = c.company_id
GROUP BY c.company_name
ORDER BY total_jobs DESC;

-- 8. Average salary by job title
SELECT job_title,
       ROUND(AVG((salary_min + salary_max) / 2), 0)
       AS average_salary_inr
FROM jobs
GROUP BY job_title
ORDER BY average_salary_inr DESC;

-- 9. Highest salary jobs
SELECT job_title, salary_min, salary_max
FROM jobs
ORDER BY salary_max DESC
LIMIT 10;

-- 10. Entry-level jobs (maximum 1 year minimum experience)
SELECT job_title, experience_min, experience_max
FROM jobs
WHERE experience_min <= 1
ORDER BY experience_min;

-- 11. Jobs requiring 3 or more minimum years
SELECT job_title, COUNT(*) AS job_count
FROM jobs
WHERE experience_min >= 3
GROUP BY job_title
ORDER BY job_count DESC;

-- 12. Most demanded skills
SELECT s.skill_name, COUNT(*) AS demand_count
FROM job_skills js
JOIN skills s ON js.skill_id = s.skill_id
GROUP BY s.skill_name
ORDER BY demand_count DESC
LIMIT 15;

-- 13. Skill demand by category
SELECT s.skill_category, COUNT(*) AS requirements
FROM job_skills js
JOIN skills s ON js.skill_id = s.skill_id
GROUP BY s.skill_category
ORDER BY requirements DESC;

-- 14. Skills required for Data Analyst roles
SELECT DISTINCT s.skill_name
FROM jobs j
JOIN job_skills js ON j.job_id = js.job_id
JOIN skills s ON js.skill_id = s.skill_id
WHERE j.job_title LIKE '%Data Analyst%'
ORDER BY s.skill_name;

-- 15. Skills required for AI/ML roles
SELECT DISTINCT s.skill_name
FROM jobs j
JOIN job_skills js ON j.job_id = js.job_id
JOIN skills s ON js.skill_id = s.skill_id
WHERE j.job_title LIKE '%AI%'
   OR j.job_title LIKE '%ML Engineer%'
   OR j.job_title LIKE '%Machine Learning%'
ORDER BY s.skill_name;

-- 16. Jobs requiring both SQL and Python
SELECT j.job_id, j.job_title
FROM jobs j
JOIN job_skills js ON j.job_id = js.job_id
JOIN skills s ON js.skill_id = s.skill_id
WHERE s.skill_name IN ('SQL', 'Python')
GROUP BY j.job_id, j.job_title
HAVING COUNT(DISTINCT s.skill_name) = 2;

-- 17. Jobs requiring Power BI
SELECT COUNT(DISTINCT j.job_id) AS power_bi_jobs
FROM jobs j
JOIN job_skills js ON j.job_id = js.job_id
JOIN skills s ON js.skill_id = s.skill_id
WHERE s.skill_name = 'Power BI';

-- 18. Jobs requiring Machine Learning
SELECT COUNT(DISTINCT j.job_id) AS ml_jobs
FROM jobs j
JOIN job_skills js ON j.job_id = js.job_id
JOIN skills s ON js.skill_id = s.skill_id
WHERE s.skill_name = 'Machine Learning';

-- 19. Number of skills required per job
SELECT j.job_id, j.job_title,
       COUNT(js.skill_id) AS skill_count
FROM jobs j
LEFT JOIN job_skills js ON j.job_id = js.job_id
GROUP BY j.job_id, j.job_title
ORDER BY skill_count DESC;

-- 20. Average salary by work mode
SELECT work_mode,
       ROUND(AVG((salary_min + salary_max) / 2), 0)
       AS average_salary_inr
FROM jobs
GROUP BY work_mode
ORDER BY average_salary_inr DESC;

-- 21. Average salary by city
SELECT l.city,
       ROUND(AVG((j.salary_min + j.salary_max) / 2), 0)
       AS average_salary_inr
FROM jobs j
JOIN locations l ON j.location_id = l.location_id
GROUP BY l.city
ORDER BY average_salary_inr DESC;

-- 22. Active vs closed postings
SELECT status, COUNT(*) AS total_postings
FROM job_postings
GROUP BY status;

-- 23. Posting sources by number of jobs
SELECT source, COUNT(*) AS total_jobs
FROM job_postings
GROUP BY source
ORDER BY total_jobs DESC;

-- 24. Applications by posting source
SELECT source,
       SUM(application_count) AS total_applications,
       ROUND(AVG(application_count), 1) AS avg_applications
FROM job_postings
GROUP BY source
ORDER BY total_applications DESC;

-- 25. Most applied-to job records
SELECT j.job_title, c.company_name,
       jp.application_count, jp.source
FROM job_postings jp
JOIN jobs j ON jp.job_id = j.job_id
JOIN companies c ON j.company_id = c.company_id
ORDER BY jp.application_count DESC
LIMIT 10;

-- 26. Monthly job posting trend
SELECT DATE_FORMAT(posting_date, '%Y-%m') AS posting_month,
       COUNT(*) AS total_postings
FROM job_postings
GROUP BY DATE_FORMAT(posting_date, '%Y-%m')
ORDER BY posting_month;

-- 27. Jobs posted by month and work mode
SELECT DATE_FORMAT(j.posted_date, '%Y-%m') AS posting_month,
       j.work_mode, COUNT(*) AS total_jobs
FROM jobs j
GROUP BY DATE_FORMAT(j.posted_date, '%Y-%m'), j.work_mode
ORDER BY posting_month, total_jobs DESC;

-- 28. Companies with average salary above ₹10 LPA
SELECT c.company_name,
       ROUND(AVG((j.salary_min + j.salary_max) / 2), 0)
       AS average_salary_inr
FROM jobs j
JOIN companies c ON j.company_id = c.company_id
GROUP BY c.company_id, c.company_name
HAVING AVG((j.salary_min + j.salary_max) / 2) > 1000000
ORDER BY average_salary_inr DESC;

-- 29. Skill combinations: SQL and Python
SELECT
    SUM(CASE WHEN s.skill_name = 'SQL' THEN 1 ELSE 0 END)
       AS sql_requirements,
    SUM(CASE WHEN s.skill_name = 'Python' THEN 1 ELSE 0 END)
       AS python_requirements
FROM job_skills js
JOIN skills s ON js.skill_id = s.skill_id;

-- 30. Job titles with highest average applications
SELECT j.job_title,
       ROUND(AVG(jp.application_count), 1) AS avg_applications
FROM jobs j
JOIN job_postings jp ON j.job_id = jp.job_id
GROUP BY j.job_title
ORDER BY avg_applications DESC;

-- 31. Rank jobs by maximum salary using a window function
SELECT job_title, salary_max,
       RANK() OVER (ORDER BY salary_max DESC) AS salary_rank
FROM jobs;

-- 32. Rank skills by demand using a CTE
WITH skill_demand AS (
    SELECT s.skill_name, COUNT(*) AS demand_count
    FROM job_skills js
    JOIN skills s ON js.skill_id = s.skill_id
    GROUP BY s.skill_name
)
SELECT skill_name, demand_count,
       DENSE_RANK() OVER (ORDER BY demand_count DESC) AS demand_rank
FROM skill_demand
ORDER BY demand_rank, skill_name;

-- 33. Salary band classification using CASE
SELECT job_title,
       ROUND((salary_min + salary_max) / 2, 0) AS avg_salary,
       CASE
           WHEN (salary_min + salary_max) / 2 < 600000
               THEN 'Below 6 LPA'
           WHEN (salary_min + salary_max) / 2 < 1200000
               THEN '6-12 LPA'
           ELSE '12 LPA and above'
       END AS salary_band
FROM jobs;

-- 34. Jobs with above-average maximum salary (subquery)
SELECT job_title, salary_max
FROM jobs
WHERE salary_max > (SELECT AVG(salary_max) FROM jobs)
ORDER BY salary_max DESC;

-- 35. Check jobs with no skill mappings
SELECT j.job_id, j.job_title
FROM jobs j
LEFT JOIN job_skills js ON j.job_id = js.job_id
WHERE js.job_id IS NULL;

-- 36. Complete job listing with company, city and salary
SELECT j.job_id, j.job_title, c.company_name,
       l.city, j.work_mode,
       j.experience_min, j.experience_max,
       j.salary_min, j.salary_max
FROM jobs j
JOIN companies c ON j.company_id = c.company_id
JOIN locations l ON j.location_id = l.location_id
ORDER BY j.job_id;

-- 37. Skill gap starter: skills required for Data Analyst jobs
-- Compare this list with the skills you already know.
SELECT s.skill_name, COUNT(*) AS number_of_jobs
FROM jobs j
JOIN job_skills js ON j.job_id = js.job_id
JOIN skills s ON js.skill_id = s.skill_id
WHERE j.job_title LIKE '%Data Analyst%'
GROUP BY s.skill_name
ORDER BY number_of_jobs DESC;

-- 38. Job postings by status and source
SELECT source, status, COUNT(*) AS posting_count
FROM job_postings
GROUP BY source, status
ORDER BY source, status;

-- 39. Jobs with the largest number of required skills
SELECT j.job_title, j.job_id,
       COUNT(js.skill_id) AS required_skills
FROM jobs j
LEFT JOIN job_skills js ON j.job_id = js.job_id
GROUP BY j.job_id, j.job_title
ORDER BY required_skills DESC
LIMIT 10;

-- 40. Summary: jobs, average salary and applications by role
SELECT j.job_title,
       COUNT(DISTINCT j.job_id) AS total_jobs,
       ROUND(AVG((j.salary_min + j.salary_max) / 2), 0)
           AS average_salary_inr,
       ROUND(AVG(jp.application_count), 1)
           AS average_applications
FROM jobs j
JOIN job_postings jp ON j.job_id = jp.job_id
GROUP BY j.job_title
ORDER BY total_jobs DESC;


USE ai_ml_job_market;

SELECT COUNT(*) AS total_companies FROM companies;
SELECT COUNT(*) AS total_locations FROM locations;
SELECT COUNT(*) AS total_skills FROM skills;
SELECT COUNT(*) AS total_jobs FROM jobs;
SELECT COUNT(*) AS total_job_skill_links FROM job_skills;
SELECT COUNT(*) AS total_postings FROM job_postings;



