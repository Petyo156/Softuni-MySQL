INSERT INTO preserves
(name, latitude, longitude, area, type, established_on)
SELECT CONCAT(name, " ", "is in South Hemisphere"), latitude, longitude, area*id, LOWER(type), established_on
FROM preserves 
WHERE latitude < 0;

UPDATE workers
SET salary = salary + 500
WHERE position_id IN(5,8,11,13);

DELETE FROM preserves 
WHERE established_on IS NULL;