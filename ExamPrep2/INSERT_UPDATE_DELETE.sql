INSERT INTO students
(first_name, last_name, age, phone_number)
SELECT reverse(lower(first_name)), reverse(lower(last_name)), age + SUBSTRING(phone_number, 1, 1), concat("1+", phone_number)
FROM students
WHERE age < 20; 

UPDATE driving_schools ds
JOIN cities c
ON ds.city_id = c.id
SET average_lesson_price = average_lesson_price + 30
WHERE c.name = "London" AND ds.night_time_driving = 1;

DELETE FROM driving_schools
WHERE night_time_driving = 0;