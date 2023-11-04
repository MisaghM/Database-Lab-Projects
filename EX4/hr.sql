-- Q1
SELECT *
FROM locations
WHERE location_id IN (
    SELECT d.location_id
    FROM employees
        INNER JOIN departments d ON d.department_id = employees.department_id
    GROUP BY d.location_id
    HAVING COUNT(*) < 2
);

-- Q2
SELECT department_id, SUM(salary) AS total_salary
FROM employees
GROUP BY department_id
HAVING SUM(salary) BETWEEN 20000 AND 30000;

-- Q3
SELECT d.*
FROM departments d
WHERE d.department_id IN (
    SELECT e.department_id
    FROM employees e
        INNER JOIN jobs j ON e.job_id = j.job_id
    group by e.department_id
    HAVING MIN(j.min_salary) >= 10000
);

-- Q4
SELECT e2.*
FROM employees e2
WHERE e2.salary > (
    SELECT MAX(e.salary) AS max_salary
    FROM employees e
    WHERE e.department_id = 2
);

-- Q5
SELECT d.*
FROM departments d
WHERE d.department_id IN (
    SELECT e.department_id
    FROM employees e
    WHERE e.salary > 15000
);

-- Q6
SELECT *
FROM dependents
WHERE relationship = 'Child'
ORDER BY last_name
LIMIT 5;

-- Q7
SELECT d.department_id, d.department_name, COUNT(*) AS employee_count
FROM employees e
    INNER JOIN departments d ON d.department_id = e.department_id
GROUP BY d.department_id;

-- Q8
SELECT e.job_id, e.department_id, COUNT(*) AS employee_count
FROM employees e
GROUP BY e.job_id, e.department_id
HAVING COUNT(*) > 1;

-- Q9
SELECT country_name
FROM countries
WHERE country_name LIKE '%n%';

-- Q10
SELECT j.*, AVG(e.salary) AS avg_salary
FROM employees e
    INNER JOIN jobs j ON j.job_id = e.job_id
GROUP BY j.job_id
ORDER BY avg_salary DESC
LIMIT 3;

-- Q11
SELECT e.first_name, e.last_name, d.department_name, j.job_title
FROM employees e
    INNER JOIN departments d ON d.department_id = e.department_id
    INNER JOIN jobs j ON j.job_id = e.job_id
WHERE d.department_id IN (1, 2, 3);

-- Q12
SELECT e.phone_number
FROM employees e
WHERE e.employee_id IN (
    SELECT e2.manager_id
    FROM employees e2
    WHERE e2.phone_number IS NOT NULL
    GROUP BY e2.manager_id
    HAVING COUNT(*) >= 2
);

-- Q13
SELECT e.first_name, e.last_name
FROM employees e
WHERE e.employee_id IN (
    SELECT d.employee_id
    FROM dependents d
    WHERE d.relationship = 'Child'
);

-- Q14
SELECT e.*
FROM employees e
WHERE e.salary BETWEEN FLOOR(RANDOM() * 10000 + 5000) AND FLOOR(RANDOM() * 10000 + 5000);
