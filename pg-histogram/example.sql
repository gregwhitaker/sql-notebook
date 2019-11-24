-- Postgres Histogram Examples

--
-- Histogram of the distribution of employee salaries across the company
--

-- Determine what kind of range we are working with:
SELECT min(salary) AS min_salary,
       max(salary) AS max_salary
FROM employees;
-- Result is a min_salary of $50,422 and a max_salary of $249,963

-- Determine a number of buckets to create based on the range (10 buckets in this example):
SELECT width_bucket(salary, 50000, 250000, 10) as bucket,
       count(*)
FROM employees
GROUP BY bucket
ORDER BY bucket;

--
-- Histogram of the distribution of employee salaries across the company with bucket ranges shown:
--
SELECT width_bucket(salary, 50000, 250000, 10) as bucket,
       int4range(CAST(MIN(salary) AS INTEGER), CAST(MAX(salary) AS INTEGER), '[]') as range,
       count(*)
FROM employees
GROUP BY bucket
ORDER BY bucket;
