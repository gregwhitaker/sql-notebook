-- Correlated Subquery Examples

-- Find all employees that make more than the average salary in their department
SELECT e.id, e.last_name, e.salary, e.department
FROM employees e
WHERE salary > (SELECT AVG(salary)
                FROM employees
                WHERE department = e.department);

-- Find all employees that make more than the average salary in their department
-- and show the department average
SELECT e.id,
       e.last_name,
       e.salary,
       e.department,
       (SELECT AVG(salary) FROM employees WHERE department = e.department) AS dept_avg_salary
FROM employees e
WHERE salary > (SELECT AVG(salary)
                FROM employees
                WHERE department = e.department);