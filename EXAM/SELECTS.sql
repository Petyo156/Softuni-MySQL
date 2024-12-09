SELECT c.id, c.name FROM countries c
LEFT JOIN athletes a ON c.id = a.country_id
WHERE a.id IS NULL
ORDER BY c.name DESC
LIMIT 15;

SELECT CONCAT(a.first_name, " ", a.last_name) AS full_name, a.age
FROM athletes a 
JOIN disciplines_athletes_medals dam 
ON a.id = dam.athlete_id 
WHERE dam.medal_id IS NOT NULL 
AND a.age = (SELECT MIN(a2.age) 
             FROM athletes a2
             JOIN disciplines_athletes_medals dam2 
             ON a2.id = dam2.athlete_id
             WHERE dam2.medal_id IS NOT NULL)
ORDER BY a.id ASC
LIMIT 2;

SELECT a.id, a.first_name, a.last_name 
FROM athletes a
LEFT JOIN disciplines_athletes_medals dam 
ON a.id = dam.athlete_id 
WHERE dam.medal_id IS NULL
ORDER BY a.id ASC;

SELECT a.id, a.first_name, a.last_name, COUNT(dam.athlete_id) AS medals_count, s.name
FROM athletes a
JOIN disciplines_athletes_medals dam ON a.id = dam.athlete_id
JOIN disciplines d ON dam.discipline_id = d.id
JOIN sports s ON d.sport_id = s.id
GROUP BY a.id, s.name
ORDER BY medals_count DESC, a.first_name ASC
LIMIT 10;

SELECT CONCAT(first_name, " ", last_name) AS full_name, 
CASE
    WHEN age <= 18 THEN "Teenager"
    WHEN age <= 25 THEN "Young adult"
    ELSE "Adult"
END AS age_group
FROM athletes
ORDER BY age DESC, first_name;

DELIMITER $$
CREATE FUNCTION udf_total_medals_count_by_country(name VARCHAR(40)) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE count_of_medals INT;
    SET count_of_medals = (
        SELECT COUNT(*) 
        FROM athletes a
        JOIN countries c ON a.country_id = c.id
        JOIN disciplines_athletes_medals dam ON a.id = dam.athlete_id
        WHERE c.name = name 
    );
    RETURN count_of_medals;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE udp_first_name_to_upper_case(letter CHAR(1))
BEGIN
	UPDATE athletes a
    SET a.first_name = UPPER(first_name) 
    WHERE RIGHT(first_name, 1) = letter;
END$$
DELIMITER ;