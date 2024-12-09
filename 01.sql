CREATE DATABASE minions;

CREATE TABLE minions(
	id INT NOT NULL UNIQUE PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    age INT
);

CREATE TABLE towns(
	town_id INT NOT NULL UNIQUE PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

ALTER TABLE minions
ADD COLUMN town_id INT;

ALTER TABLE minions
ADD CONSTRAINT fk_town_id
FOREIGN KEY (town_id) REFERENCES towns(id);

INSERT INTO towns(id, name) VALUES
(1, "Sofia"),
(2, "Plovdiv"),
(3, "Varna");

INSERT INTO minions VALUES
(1, "Kevin", 22, 1),
(2, "Bob", 15, 3),
(3, "Steward", NULL, 2);

TRUNCATE TABLE minions;

DROP TABLE minions, towns;

DROP TABLE minions;

CREATE TABLE people(
	id INT NOT NULL UNIQUE PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    picture BLOB,
    height DOUBLE(10, 2),
    weight DOUBLE(10, 2),
    gender CHAR(1) NOT NULL,
    birthdate DATE NOT NULL,
    biography TEXT 
);

INSERT INTO people (name, picture, height, weight, gender, birthdate, biography) 
VALUES 
('John Doe', NULL, 180.50, 75.30, 'M', '1990-05-14', 'John is a software engineer who loves to travel and code.');

INSERT INTO people (name, picture, height, weight, gender, birthdate, biography) 
VALUES 
('Jane Smith', NULL, 165.00, 62.50, 'F', '1985-11-23', 'Jane is a freelance graphic designer with a passion for painting.');

INSERT INTO people (name, picture, height, weight, gender, birthdate, biography) 
VALUES 
('Michael Brown', NULL, 170.75, 80.10, 'M', '1978-04-08', 'Michael is a professional chef known for his creative culinary dishes.');

INSERT INTO people (name, picture, height, weight, gender, birthdate, biography) 
VALUES 
('Emma Johnson', NULL, 155.60, 58.40, 'F', '1995-07-30', 'Emma is an aspiring actress with experience in theater and TV shows.');

INSERT INTO people (name, picture, height, weight, gender, birthdate, biography) 
VALUES 
('Chris Lee', NULL, 182.20, 90.75, 'M', '1992-02-19', 'Chris is an avid runner and works as a fitness coach in a local gym.');

SELECT * FROM people;


CREATE TABLE users(
	id INT NOT NULL UNIQUE PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(30) NOT NULL,
    password VARCHAR(26) NOT NULL,
    profile_picture BLOB,
    last_login_time DATETIME,
    is_deleted BOOLEAN
);

INSERT INTO users (username, password, profile_picture, last_login_time, is_deleted) 
VALUES 
('john_doe', 'pass1234!', NULL, '2024-09-11 10:30:00', FALSE);

INSERT INTO users (username, password, profile_picture, last_login_time, is_deleted) 
VALUES 
('jane_smith', 'securePass22$', NULL, '2024-09-10 09:15:00', FALSE);

INSERT INTO users (username, password, profile_picture, last_login_time, is_deleted) 
VALUES 
('mike_brown', 'Mike2024#', NULL, '2024-09-08 17:45:00', TRUE);

INSERT INTO users (username, password, profile_picture, last_login_time, is_deleted) 
VALUES 
('emma_johnson', 'emmaPass!', NULL, '2024-09-09 14:00:00', FALSE);

INSERT INTO users (username, password, profile_picture, last_login_time, is_deleted) 
VALUES 
('chris_lee', 'chrisSecure88%', NULL, '2024-09-11 12:20:00', FALSE);

SELECT * FROM users;

ALTER TABLE users
DROP PRIMARY KEY,
ADD CONSTRAINT pk_users
PRIMARY KEY (id, username);

ALTER TABLE users 
CHANGE COLUMN last_login_time last_login_time datetime default NOW();

alter table users
drop primary key,
add primary key (id);

ALTER TABLE users
MODIFY username VARCHAR(30) NOT NULL UNIQUE;

CREATE DATABASE movies;

CREATE TABLE directors(
	id INT NOT NULL UNIQUE PRIMARY KEY AUTO_INCREMENT,
    director_name VARCHAR(100) NOT NULL,
    notes TEXT
);

CREATE TABLE genres(
	id INT NOT NULL UNIQUE PRIMARY KEY AUTO_INCREMENT,
    genre_name VARCHAR(50) NOT NULL,
    notes TEXT
);

CREATE TABLE categories(
	id INT NOT NULL UNIQUE PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL,
    notes TEXT
);

CREATE TABLE movies(
	id INT NOT NULL UNIQUE PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    director_id INT,
    copyright_year DATE,
    length DOUBLE(10,2),
    genre_id INT,
    category_id INT,
    rating DOUBLE(5,2),
    notes TEXT
);

INSERT INTO directors(director_name, notes) VALUES
("PESHO", "MLADOST"),
("PESHO", "MLADOST"),
("PESHO", "MLADOST"),
("PESHO", "MLADOST"),
("PESHO", "MLADOST");

INSERT INTO genres(genre_name, notes) VALUES
("PESHO", "MLADOST"),
("PESHO", "MLADOST"),
("PESHO", "MLADOST"),
("PESHO", "MLADOST"),
("PESHO", "MLADOST");

INSERT INTO categories(category_name, notes) VALUES
("PESHO", "MLADOST"),
("PESHO", "MLADOST"),
("PESHO", "MLADOST"),
("PESHO", "MLADOST"),
("PESHO", "MLADOST");

INSERT INTO movies(title) VALUES
("aiwe"),
("aiwe"),
("aiwe"),
("aiwe"),
("aiwe");