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
SELECT width_bucket(salary, 50000, 250000, 10) AS bucket,
       int4range(cast(min(salary) AS INTEGER), cast(max(salary) AS INTEGER)) AS range,
       count(*)
FROM employees
GROUP BY bucket
ORDER BY bucket;

-- Draw a histogram in the console
-- 1	[50422,69902)	91	■■■■■■■■■■■■■■■■■■■■■■■
-- 2	[70579,89944)	99	■■■■■■■■■■■■■■■■■■■■■■■■■
-- 3	[90502,109966)	106	■■■■■■■■■■■■■■■■■■■■■■■■■■
-- 4	[110326,129867)	86	■■■■■■■■■■■■■■■■■■■■■
-- 5	[130338,149944)	106	■■■■■■■■■■■■■■■■■■■■■■■■■■
-- 6	[150162,169872)	105	■■■■■■■■■■■■■■■■■■■■■■■■■■
-- 7	[170025,189920)	102	■■■■■■■■■■■■■■■■■■■■■■■■■
-- 8	[190361,209859)	84	■■■■■■■■■■■■■■■■■■■■■
-- 9	[210776,229683)	100	■■■■■■■■■■■■■■■■■■■■■■■■■
-- 10	[230091,249963)	121	■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

WITH salary_stats AS (
    SELECT min(salary) as min,
           max(salary) as max
    FROM employees
),
histogram AS (
    SELECT width_bucket(salary, 50000, 250000, 10) AS bucket,
           int4range(cast(min(salary) AS INTEGER), cast(max(salary) AS INTEGER)) AS range,
           count(*) AS freq
    FROM employees, salary_stats
    GROUP BY bucket
    ORDER BY bucket
)
SELECT bucket,
       range,
       freq,
       repeat('■', (freq::float / max(freq) over() * 30)::int) AS bar
from histogram;