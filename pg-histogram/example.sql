-- Postgres Histogram Examples

-- Before creating histograms you need to do some queries to figure out
-- the range of data you are working with. In this case we need to figure
-- out the range of salaries across the company:
SELECT min(salary) AS min_salary,
       max(salary) AS max_salary
FROM employees;

-- This query tells us that we have a min_salary of $50,422 and a max_salary of $249,963

-- Histogram of the distribution of employee salaries across the company (10 buckets)
SELECT width_bucket(salary, 50000, 250000, 10) as bucket,
       count(*)
FROM employees
GROUP BY bucket
ORDER BY bucket;

-- Histogram of the distribution of employee salaries across the company with bucket ranges shown (10 buckets)
SELECT width_bucket(salary, 50000, 250000, 10) as bucket,
       int4range(CAST(MIN(salary) AS INTEGER), CAST(MAX(salary) AS INTEGER), '[]') as range,
       count(*)
FROM employees
GROUP BY bucket
ORDER BY bucket;
