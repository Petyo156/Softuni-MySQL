SELECT MAX(magic_wand_size) AS longest_magic_wand FROM wizzard_deposits;

SELECT deposit_group, MAX(magic_wand_size) AS longest_magic_wand FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY longest_magic_wand, deposit_group; 

SELECT deposit_group, SUM(deposit_amount) AS total_sum 
FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY total_sum; 

SELECT deposit_group, SUM(deposit_amount) AS total_sum 
FROM wizzard_deposits
WHERE magic_wand_creator = "Ollivander family"
GROUP BY deposit_group
ORDER BY deposit_group; 

SELECT deposit_group, SUM(deposit_amount) AS total_sum 
FROM wizzard_deposits
WHERE magic_wand_creator = "Ollivander family"
GROUP BY deposit_group
HAVING total_sum < 150000
ORDER BY total_sum DESC;  

SELECT deposit_group, magic_wand_creator, MIN(deposit_charge) AS "min_deposit_charge"
FROM wizzard_deposits
GROUP BY deposit_group, magic_wand_creator
ORDER BY magic_wand_creator, deposit_group;

SELECT 
	CASE 
		WHEN age < 11 THEN '[0-10]'
        WHEN age < 21 THEN '[11-20]'
        WHEN age < 31 THEN '[21-30]'
        WHEN age < 41 THEN '[31-40]'
        WHEN age < 51 THEN '[41-50]'
        WHEN age < 61 THEN '[51-60]'
        WHEN age > 60 THEN '[61+]'
	END AS age_group,
    COUNT(*) AS wizard_count
FROM wizzard_deposits
GROUP BY age_group
ORDER BY age_group;

SELECT SUBSTR(first_name,1,1) AS first_letter
FROM wizzard_deposits
WHERE deposit_group = "Troll Chest"
GROUP BY first_letter
ORDER BY first_letter;

SELECT deposit_group, is_deposit_expired, 
AVG(deposit_interest) AS average_interest
FROM wizzard_deposits
WHERE deposit_start_date > '1985-01-01'
GROUP BY deposit_group, is_deposit_expired
ORDER BY deposit_group DESC, is_deposit_expired;

SELECT * FROM wizzard_deposits;

SELECT department_id, MIN(salary) AS minimum_salary
FROM employees
WHERE department_id IN(2, 5, 7) AND
hire_date > '2000-01-01'
GROUP BY department_id
ORDER BY department_id;

DROP TABLE high_paid_employees;

CREATE TABLE high_paid_employees
SELECT * FROM employees
WHERE salary > 30000;

DELETE FROM high_paid_employees WHERE manager_id = 42;

UPDATE high_paid_employees SET salary = salary + 5000
WHERE department_id = 1;

SELECT department_id, AVG(salary) AS avg_salary 
FROM high_paid_employees
GROUP BY department_id
ORDER BY department_id;

SELECT department_id, MAX(salary) AS max_salary
FROM employees
GROUP BY department_id
HAVING max_salary NOT BETWEEN 30000 AND 70000
ORDER BY department_id;

SELECT COUNT(salary) AS ""
FROM employees
WHERE manager_id IS NULL;

SELECT department_id, SUM(salary) AS total_salary
FROM employees
GROUP BY department_id
ORDER BY department_id;

SELECT
    deposit_group
FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY AVG(magic_wand_size) LIMIT 1;

SELECT
    department_id,
    (SELECT DISTINCT e.salary
     FROM employees AS e
     WHERE e.department_id = employees.department_id
     ORDER BY e.salary DESC
     LIMIT 1 OFFSET 2) AS 'third_highest_salary'
FROM employees
GROUP BY department_id
HAVING third_highest_salary IS NOT NULL
ORDER BY department_id;

SELECT
    first_name,
    last_name,
    department_id
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees AS e
    WHERE e.department_id = employees.department_id
)
GROUP BY department_id, employee_id
ORDER BY department_id, employee_id LIMIT 10;

SELECT * FROM employees;