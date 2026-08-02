-- Active: 1785125580166@@localhost@5432
-- Active: 1785117085461@@127.0.0.1@5432
/*
Question; What are the top-paying data analyst job?
-Identify the top 10 highest-paying Data Analyst roles that are available remotely.
-Focuses on job postings with specified salaries (remove nulls).
Highlight the top-paying opportunities for Data Analyst, offering insights into employee-Why? 
*/
SELECT
    job_postings_fact.job_id,
    job_postings_fact.job_title_short,
    Round(job_postings_fact.salary_year_avg) AS salary_year_avg,
    company_dim.name AS company_name
FROM
    job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    salary_year_avg IS NOT NULL
    AND job_location = 'Anywhere'
    AND job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg DESC
LIMIT
    10;
