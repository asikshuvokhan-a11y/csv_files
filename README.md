# Introduction
Dive into the data job market! Focusing on data analyst roles, this project explores top-paying jobs, in-demand skills, and where high demand meets high salary in data analytics.
SQL queries? Check them out here: [project_sql folder ](/project1_sql/)

# Background 
Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streaming others work to find optimal jobs.

### The questions i wanted to answer through my SQL queries were:
1. What are the top-paying data analyst jobs? 
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts? 
4. Which skills are associated with higher salaries? 
5. What are the most optimal skills to learn ?

# Tools I used
For my deep dive into the data analyst job market, I harnessed the power of several key tools:
- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job postings data. 
- **Visual studio code:** My go-to for database management and executing  SQL queries.
- **Git and GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market.
Here's how I approached each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.


```sql
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
```
Here's the breakdown of the top data analyst jobs in 2023:

- **Wide salary Range:** Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.

- **Diverse Employers:** Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.

- **Job Title Variety:** There's a high diversity in job titles, from Data analyst  to Director of Analytics, reflecting varied roles and specializations within  data analytics,
![Top Paying Roles](assets\1_tops_paying_roles.png)
*Bar graph visualizing the salary for the top 10 salaries for data analyst; Gemini generated this graph from my SQL query results*

### 2. Skills Required for Top Paying Jobs

To understand what specific skills are required for the highest-paying Data Analyst roles, I joined the top 10 paying jobs dataset with the skill mapping tables (`skills_job_dim` and `skills_dim`). This identifies which tools and technologies appear most frequently in high-salary job postings.

```sql
WITH top_paying_job AS (
    SELECT
        job_postings_fact.job_id,
        job_postings_fact.job_title_short,
        ROUND(job_postings_fact.salary_year_avg) AS salary_year_avg,
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
    LIMIT 10
)
SELECT
    top_paying_job.*,
    skills
FROM
    top_paying_job
    INNER JOIN skills_job_dim ON top_paying_job.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;```

Bar graph visualizing the most frequent skills required in top-paying remote Data Analyst jobs.

Breakdown of Most Demanded Skills in Top-Paying Roles


Skill         Count in Top Jobs
-------------------------------
SQL                   8
Python                7
Tableau               6
R                     4
Snowflake             3
Pandas                2
Excel                 2
Azure                 2
AWS                   2



Key Insights
SQL is Non-Negotiable: SQL is required in 100% of the top-paying job listings that specified skill requirements, proving it to be the foundational core skill for high-earning data analysts.

Python Dominates Data Scripting: Python appears in 7 out of 8 job listings, significantly outperforming R (4 listings), showing a strong employer preference for versatile programming languages in high-salary roles.

Tableau Leads Data Visualization: Tableau is the dominant Business Intelligence tool among top earners, appearing 6 times compared to Power BI's 2 appearances.

Cloud & Big Data Stack Matter: Advanced tools like Snowflake, AWS, Azure, and Pandas consistently appear in top-tier listings, indicating that top-paying roles expect analysts to work directly with modern cloud data architectures.

#### 3. Most In-Demand Skills for Data Analysts

I wanted to find out which skills appear the most in all remote Data Analyst job listings. This query counts how many times each skill shows up across job posts to see what employers are looking for the most.

```sql 
SELECT
    skills,
    count(skills_job_dim.job_id) AS demand_count
FROM
    job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_work_from_home = 'True'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT
    5;
```

Bar chart showing the top 5 most demanded skills for remote Data Analyst jobs.

Skill          Demand Count
---------------------------
SQL                   7,291
Excel                 4,611
Python                4,330
Tableau               3,745
Power BI              2,609


What I Found Out:
SQL is #1 by far: SQL appeared in 7,291 job posts, making it the most asked-for skill on the list.

Excel is still huge: Even with newer tech tools, Excel came in 2nd place with 4,611 posts.

Python leads programming: Python takes 3rd place with 4,330 mentions, proving it is a key skill for data work.

Visualization tools are close: Both Tableau (3,745) and Power BI (2,609) are in top demand for creating charts and dashboards.





### 4. Top Paying Skills for Data Analysts

I wanted to find out which skills actually pay the most money for remote Data Analyst jobs. This query calculates the average yearly salary for each skill so we can see which tools can help you earn the highest income.

```sql
SELECT
    skills,
    round(avg(salary_year_avg), 0) AS avg_salary
FROM
    job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    salary_year_avg IS NOT NULL
    AND job_title_short = 'Data Analyst'
    AND job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT
    25;
```

Bar chart showing the top 25 highest paying skills for remote Data Analyst jobs.

```text
Skill                 Average Salary
------------------------------------
pyspark                     $208,172
bitbucket                   $189,155
couchbase                   $160,515
watson                      $160,515
datarobot                   $155,486
gitlab                      $154,500
swift                       $153,750
jupyter                     $152,777
pandas                      $151,821
elasticsearch               $145,000
golang                      $145,000
numpy                       $143,513
databricks                  $141,907
linux                       $136,508
kubernetes                  $132,500
atlassian                   $131,162
twilio                      $127,000
airflow                     $126,103
scikit-learn                $125,781
jenkins                     $125,436
notion                      $125,000
scala                       $124,903
postgresql                  $123,879
gcp                         $122,500
microstrategy               $121,619
```


What I Found Out:
PySpark pays the highest: PySpark leads the list with a huge average salary of $208,172, showing that big data processing is super valuable.

Data science & AI libraries pay very well: Tools like Pandas ($151,821), NumPy ($143,513), and Scikit-learn ($125,781) show up high on the list, proving that advanced data analysis skills lead to bigger paychecks.

DevOps and cloud skills boost salary: Software development and cloud tools like Bitbucket, GitLab, Databricks, Airflow, and GCP are everywhere in this top list, meaning employers pay more for analysts who can handle code and cloud pipelines.


### 5. Most Optimal Skills for Data Analysts (High Demand & High Salary)

I wanted to find the "sweet spot" skills—tools that are asked for in a lot of job posts AND pay a great salary. This query combines skill demand with average salaries for remote Data Analyst roles, filtering for skills with more than 10 job postings to avoid weird high-salary outliers.

```sql
WITH skills_demand AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM
        job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND job_work_from_home = TRUE
        AND salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id,
        skills_dim.skills
),
avg_salary AS (
    SELECT
        skills_job_dim.skill_id,
        skills_dim.skills,
        ROUND(AVG(salary_year_avg), 0) AS average_salary
    FROM
        job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        salary_year_avg IS NOT NULL
        AND job_title_short = 'Data Analyst'
        AND job_work_from_home = TRUE
    GROUP BY
        skills_job_dim.skill_id,
        skills_dim.skills
)
SELECT
    skills_demand.skill_id,
    skills_demand.skills, 
    demand_count,
    avg_salary.average_salary 
FROM
    skills_demand
    INNER JOIN avg_salary ON skills_demand.skill_id = avg_salary.skill_id 
WHERE
    demand_count > 10
ORDER BY
    demand_count DESC,
    average_salary DESC
LIMIT
    25;
```

Scatter plot showing high-demand vs high-paying skills for remote Data Analyst jobs.

<pre>
Skill           Demand Count     Average Salary
-----------------------------------------------
sql             398                     $97,237
excel           256                     $87,288
python          236                    $101,397
tableau         230                     $99,288
r               148                    $100,499
power bi        110                     $97,431
sas             63                      $98,902
sas             63                      $98,902
powerpoint      58                      $88,701
looker          49                     $103,795
word            48                      $82,576
snowflake       37                     $112,948
oracle          37                     $104,534
sql server      35                      $97,786
azure           34                     $111,225
aws             32                     $108,317
sheets          32                      $86,088
flow            28                      $97,200
go              27                     $115,320
spss            24                      $92,170
vba             24                      $88,783
hadoop          22                     $113,193
jira            20                     $104,918
javascript      20                      $97,587
sharepoint      18                      $81,634
</pre>
What I Found Out:

- SQL and Python are top choices: SQL leads in total demand (398 postings) with a solid average salary of $97,237, while Python crosses the $100k mark ($101,397) with high demand (236 postings).

- Cloud and Big Data pay higher: Tools like Go ($115,320), Hadoop ($113,193), Snowflake ($112,948), and Azure ($111,225) have lower demand counts but consistently pay well over $100,000 per year.

- Core visualization tools remain safe bets: Tableau ($99,288) and Power BI ($97,431) show strong demand and steady salaries near $100k, making them great tools to combine with SQL or Python.




# What I Learned
# What I Learned

Throughout this project, I strengthened my SQL skills and gained practical experience analyzing real-world job market data:

* **Complex SQL Queries:** Learned how to use Common Table Expressions (CTEs) to organize complex queries and calculate multiple metrics (like skill demand and average salaries) in a single script.
* **Joining Multiple Tables:** Got comfortable using `INNER JOIN`s to connect job posting facts with skill dimension tables without losing data integrity.
* **Data Aggregation & Filtering:** Used `GROUP BY`, `COUNT()`, `ROUND()`, and `AVG()` to calculate summary statistics, while filtering out salary outliers with `WHERE` and `HAVING` clauses.
* **Real-World Job Market Insights:** Discovered that while SQL and Excel are the most frequently requested skills, advanced programming and cloud tools (like PySpark, Python, and Snowflake) command much higher average salaries.


# Conclusions


This project provided key insights into the remote Data Analyst job market and where to focus learning efforts:

* **SQL and Excel are non-negotiable:** They show up in the highest number of job postings, making them essential baseline tools to land an entry-level role.
* **Advanced tech pays more:** Specialized tools like PySpark, Python, and cloud platforms offer significantly higher salaries than standard reporting tools.
* **The Best Strategy:** Combining **SQL**, **Python**, and a visualization tool (**Tableau** or **Power BI**) gives the best balance of high job availability and strong earning potential.