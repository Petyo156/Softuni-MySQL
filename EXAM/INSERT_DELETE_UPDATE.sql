INSERT INTO athletes (first_name, last_name, age, country_id)
    SELECT UPPER(a.first_name), 
           CONCAT(a.last_name, ' comes from ', c.name), 
           a.age + a.country_id, 
           a.country_id
    FROM athletes a
    JOIN countries c ON a.country_id = c.id
    WHERE SUBSTRING(c.name, 1, 1) = 'A';

UPDATE disciplines d
SET d.name = REPLACE(d.name,'weight','');

DELETE FROM athletes
WHERE age > 35;