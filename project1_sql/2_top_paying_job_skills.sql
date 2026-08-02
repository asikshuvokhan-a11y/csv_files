/*
Question: What skills are required for the top paying data analyst jobs?
-Use the top 10 highest paying Data Analyst jobs from the first Query
-Add the specific skills required for these roles
-Why? It provides a detailed look at which high paying jobs demand certain skills,
helping job seekers understand which skills to develop that align with top salaries
*/
WITH
    top_paying_job AS (
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
            10
    )
SELECT
    top_paying_job.*,
    skills
FROM
    top_paying_job
    INNER JOIN skills_job_dim ON top_paying_job.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC
