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
WITH salary_stats AS (
    SELECT min(salary) as min,
           max(salary) as max
    FROM employees
)
SELECT width_bucket(salary, min, max, 9) AS bucket,
       int4range(cast(min(salary) AS INTEGER), cast(max(salary) AS INTEGER), '[]') AS range,
       count(*)
FROM employees, salary_stats
GROUP BY bucket
ORDER BY bucket;

-- Draw a histogram in the console
-- 1	[50422,72537)	103	■■■■■■■■■■■■■■■■■■■■■■■■
-- 2	[72799,94739)	108	■■■■■■■■■■■■■■■■■■■■■■■■■
-- 3	[95014,116743)	120	■■■■■■■■■■■■■■■■■■■■■■■■■■■■
-- 4	[117085,139062)	93	■■■■■■■■■■■■■■■■■■■■■
-- 5	[139215,161215)	116	■■■■■■■■■■■■■■■■■■■■■■■■■■■
-- 6	[161360,183117)	114	■■■■■■■■■■■■■■■■■■■■■■■■■■
-- 7	[183604,205556)	98	■■■■■■■■■■■■■■■■■■■■■■■
-- 8	[205779,227714)	117	■■■■■■■■■■■■■■■■■■■■■■■■■■■
-- 9	[227819,249853)	130	■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
-- 10	[249963,249964)	1

WITH salary_stats AS (
    SELECT min(salary) as min,
           max(salary) as max
    FROM employees
),
histogram AS (
    SELECT width_bucket(salary, min, max, 9) AS bucket,
           int4range(cast(min(salary) AS INTEGER), cast(max(salary) AS INTEGER), '[]') AS range,
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
