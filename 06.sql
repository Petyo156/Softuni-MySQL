SELECT employee_id, job_title, e.address_id, address_text FROM employees e
JOIN addresses a 
ON e.address_id = a.address_id
ORDER BY e.address_id
LIMIT 5;

SELECT first_name, last_name, t.name, a.address_text FROM employees e
JOIN addresses a 
ON e.address_id = a.address_id
JOIN towns t
ON a.town_id = t.town_id
ORDER BY e.first_name, e.last_name
LIMIT 5;

SELECT employee_id, first_name, last_name, d.name as department_name FROM employees e
JOIN departments d 
ON e.department_id = d.department_id
WHERE d.name = 'Sales' 
ORDER BY e.employee_id DESC;

SELECT employee_id, first_name, salary, d.name as department_name FROM employees e
JOIN departments d 
ON e.department_id = d.department_id
WHERE e.salary > 15000 
ORDER BY d.department_id DESC
LIMIT 5;

SELECT e.employee_id, e.first_name FROM employees e
LEFT JOIN employees_projects ep 
ON e.employee_id = ep.employee_id
WHERE ep.project_id IS NULL
ORDER BY e.employee_id DESC
LIMIT 3;

SELECT e.first_name, e.last_name, e.hire_date, d.name FROM employees e
JOIN departments d 
ON e.department_id = d.department_id
WHERE e.hire_date > '1999-01-01' AND
d.name = 'Sales' OR d.name = 'Finance'
ORDER BY e.hire_date;

SELECT e.employee_id, e.first_name, p.name AS project_name FROM employees e
JOIN employees_projects ep  
ON e.employee_id = ep.employee_id
JOIN projects p
ON ep.project_id = p.project_id
WHERE DATE(p.start_date) > '2002-08-13' AND 
p.end_date IS NULL
ORDER BY e.first_name, project_name
LIMIT 5;

SELECT e.employee_id, e.first_name, 
IF(YEAR(p.start_date) = 2005, NULL, p.name) AS project_name FROM employees e
JOIN employees_projects ep 
ON e.employee_id = ep.employee_id
JOIN projects p 
ON ep.project_id = p.project_id
WHERE e.employee_id IN (24) 
ORDER BY project_name;

SELECT e.employee_id, e.first_name, 
e.manager_id, m.first_name AS manager_name 
FROM employees e
JOIN employees m  
ON e.manager_id = m.employee_id
WHERE e.manager_id IN(3, 7)  
ORDER BY e.first_name;

SELECT e.employee_id, 
CONCAT(e.first_name, " ", e.last_name) AS employee_name, 
CONCAT(m.first_name, " ", m.last_name) AS manager_name, d.name AS department_name 
FROM employees e
JOIN employees m  
ON e.manager_id = m.employee_id
JOIN departments d
ON e.department_id = d.department_id
ORDER BY e.employee_id
LIMIT 5;

SELECT AVG(salary) AS min_average_salary FROM employees
GROUP BY department_id
ORDER BY min_average_salary
LIMIT 1;

SELECT c.country_code, m.mountain_range, p.peak_name, p.elevation
FROM countries c
JOIN mountains_countries mc
ON c.country_code = mc.country_code
JOIN mountains m
ON mc.mountain_id = m.id
JOIN peaks p
ON m.id = p.mountain_id
WHERE c.country_code = "BG" AND p.elevation > 2835
ORDER BY p.elevation DESC; 


SELECT c.country_code, COUNT(*) AS mountain_range_count
FROM countries c
JOIN mountains_countries mc
ON c.country_code = mc.country_code
WHERE c.country_code IN ("BG", "RU", "US") 
GROUP BY c.country_code
ORDER BY mountain_range_count DESC; 

SELECT c.country_name, r.river_name
FROM countries c
LEFT JOIN countries_rivers cr
ON c.country_code = cr.country_code
LEFT JOIN rivers r
ON cr.river_id = r.id
WHERE c.continent_code IN ("AF") 
ORDER BY c.country_name
LIMIT 5; 

SELECT COUNT(*) 
FROM countries c
LEFT JOIN mountains_countries mc
ON c.country_code = mc.country_code
WHERE mc.mountain_id IS NULL;

SELECT
    c.country_name,
    MAX(p.elevation) AS `highest_peak_elevation`,
    MAX(r.length) AS `longest_river_length`
FROM countries AS c
    JOIN mountains_countries AS mc ON c.country_code = mc.country_code
    JOIN peaks AS p ON mc.mountain_id = p.mountain_id
    JOIN countries_rivers cr on c.country_code = cr.country_code
    JOIN rivers r on r.id = cr.river_id
GROUP BY c.country_name
ORDER BY highest_peak_elevation DESC, longest_river_length DESC
LIMIT 5;

