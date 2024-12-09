SELECT concat(first_name, " ", last_name) AS full_name, age FROM students
WHERE first_name LIKE "%a%" AND
	age = (SELECT MIN(age) FROM students WHERE first_name LIKE "%a%")
ORDER BY id;

SELECT ds.id, ds.name, c.brand FROM driving_schools ds
LEFT JOIN instructors_driving_schools ids
ON ds.id = ids.driving_school_id
LEFT JOIN cars c
ON ds.car_id = c.id
WHERE ids.instructor_id IS NULL
ORDER BY c.brand, ds.id
LIMIT 5;

SELECT i.first_name, i.last_name, COUNT(s.id) AS students_count, c.name as city
FROM instructors i
JOIN instructors_driving_schools ids ON i.id = ids.instructor_id
JOIN driving_schools ds ON ids.driving_school_id = ds.id
JOIN cities c ON ds.city_id = c.id
JOIN instructors_students ins ON i.id = ins.instructor_id
JOIN students s ON ins.instructor_id = s.id
GROUP BY i.id, i.first_name, i.last_name, c.name
HAVING COUNT(s.id) > 1
ORDER BY students_count DESC, i.first_name ASC;

SELECT c.name, COUNT(i.id) AS instructors_count FROM instructors i
JOIN instructors_driving_schools ids ON i.id = ids.instructor_id
JOIN driving_schools ds ON ids.driving_school_id = ds.id
JOIN cities c ON ds.city_id = c.id
GROUP BY c.name
HAVING instructors_count > 0
ORDER BY instructors_count DESC;

SELECT CONCAT(first_name, " ", last_name) AS full_name, 
CASE
    WHEN YEAR(has_a_license_from) < 1990 THEN "Specialist"
    WHEN YEAR(has_a_license_from) < 2000 THEN "Advanced"
    WHEN YEAR(has_a_license_from) < 2008 THEN "Experienced"
    WHEN YEAR(has_a_license_from) < 2015 THEN "Qualified"
    WHEN YEAR(has_a_license_from) < 2020 THEN "Provisional"
    ELSE "Trainee"
END AS level
FROM instructors
ORDER BY YEAR(has_a_license_from), first_name;

DELIMITER $$
CREATE FUNCTION udf_average_lesson_price_by_city (city_name VARCHAR(40)) 
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    DECLARE result DECIMAL(12,2);
    SET result = (
        SELECT AVG(ds.average_lesson_price) 
        FROM driving_schools ds
        JOIN cities c ON ds.city_id = c.id
        WHERE c.name = city_name
    );
    RETURN result;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE udp_find_school_by_car(brand VARCHAR(20))
BEGIN
	SELECT ds.name, ds.average_lesson_price FROM driving_schools ds
    JOIN cars c ON ds.car_id = c.id
    WHERE c.brand = brand
    ORDER BY average_lesson_price DESC;
END$$
DELIMITER ;
