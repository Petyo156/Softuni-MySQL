SELECT CONCAT(first_name, " ", last_name) AS full_name, DATEDIFF('2024-01-01', start_date) AS days_of_experience 
FROM workers 
WHERE DATEDIFF('2024-01-01', start_date) > 1825
ORDER BY days_of_experience DESC
LIMIT 10;

SELECT w.id, w.first_name, w.last_name , p.name, c.country_code 
FROM workers w
JOIN preserves p
ON w.preserve_id = p.id
JOIN countries_preserves cp
ON cp.preserve_id = p.id
JOIN countries c
ON cp.country_id = c.id
WHERE w.salary > 5000 AND age < 50
ORDER BY c.country_code ASC;

SELECT p.name, COUNT(*) AS armed_workers
FROM preserves p
JOIN workers w 
ON p.id = w.preserve_id
WHERE is_armed = 1
GROUP BY p.name
ORDER BY armed_workers DESC, p.name ASC;

SELECT p.name, c.country_code, YEAR(p.established_on) as founded_in
FROM preserves p
JOIN countries_preserves cp
ON p.id = cp.preserve_id
JOIN countries c
ON cp.country_id = c.id
WHERE MONTH(p.established_on) = '5'
ORDER BY p.established_on ASC
LIMIT 5;

SELECT id, name, 
CASE
	WHEN area <= 100 THEN 'very small'
    WHEN area <= 1000 THEN 'small'
    WHEN area <= 10000 THEN 'medium'
    WHEN area <= 50000 THEN 'large'
    ELSE 'very large'
END AS category
FROM preserves
ORDER BY area DESC;

DELIMITER $$
CREATE FUNCTION udf_average_salary_by_position_name(name VARCHAR(40))  
RETURNS DECIMAL(19, 2)
DETERMINISTIC
BEGIN
	RETURN (SELECT AVG(salary) FROM workers w 
    JOIN positions p ON w.position_id = p.id
    WHERE p.name = name); 
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE udp_increase_salaries_by_country(country_name VARCHAR(40))
BEGIN
	UPDATE workers w
    JOIN preserves p 
    ON w.preserve_id = p.id
    JOIN countries_preserves cp
    ON p.id = cp.preserve_id
    JOIN countries c 
    ON cp.country_id = c.id
    SET w.salary = w.salary * 1.05
    WHERE c.name = country_name;
    
    -- SELECT w.first_name, w.last_name, w.salary FROM workers w
    -- JOIN preserves p 
    -- ON w.preserve_id = p.id
    -- JOIN countries_preserves cp
    -- ON p.id = cp.preserve_id
    -- JOIN countries c 
    -- ON cp.country_id = c.id
    -- WHERE c.name = country_name;
END$$
DELIMITER ;

SELECT * FROM workers;
SELECT * FROM preserves;
SELECT * FROM countries;
SELECT * FROM countries_preserves;
SELECT * FROM positions;