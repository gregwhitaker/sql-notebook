-- Correlated Subquery Examples

-- Find all employees that make more than the average salary in their department
SELECT e.id, e.last_name, e.salary, e.department
FROM employees e
WHERE salary > (SELECT AVG(salary)
                FROM employees
                WHERE department = e.department);

-- Find all employees that make more than the average salary in their department
-- and show the department average with difference
SELECT e.id,
       e.last_name,
       e.salary,
       e.department,
       (SELECT ROUND(AVG(salary)) FROM employees WHERE department = e.department) AS dept_avg_salary,
       e.salary - (SELECT ROUND(AVG(salary)) FROM employees WHERE department = e.department) AS salary_diff
FROM employees e
WHERE salary > (SELECT AVG(salary)
                FROM employees
                WHERE department = e.department)
ORDER BY salary_diff DESC;