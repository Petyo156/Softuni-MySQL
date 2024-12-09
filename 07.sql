DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above_35000()
BEGIN
	SELECT first_name, last_name FROM employees
    WHERE salary > 35000
    ORDER BY first_name, last_name;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above(chislo DECIMAL(12,4))
BEGIN
	SELECT first_name, last_name FROM employees
    WHERE salary >= chislo
    ORDER BY first_name, last_name, employee_id;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE usp_get_towns_starting_with(letter VARCHAR(20))
BEGIN
	SELECT name AS town_name FROM towns
    WHERE name LIKE CONCAT(letter, "%")
    ORDER BY town_name;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above(chislo DECIMAL(12,4))
BEGIN
	SELECT first_name, last_name FROM employees
    WHERE salary >= chislo
    ORDER BY first_name, last_name, employee_id;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE usp_get_employees_from_town(town_name VARCHAR(50))
BEGIN
	SELECT first_name, last_name FROM employees e
    JOIN addresses a
    ON e.address_id = a.address_id
    JOIN towns t
    ON a.town_id = t.town_id
    WHERE t.name = town_name
    ORDER BY first_name, last_name, employee_id;
END$$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION ufn_get_salary_level(salary DECIMAL(12, 2))
RETURNS VARCHAR(7)
DETERMINISTIC
BEGIN
	DECLARE salary_level VARCHAR(7);
    
	IF(salary < 30000) THEN
    SET salary_level = 'Low';
    ELSEIF(salary BETWEEN 30000 AND 50000) THEN
    SET salary_level = 'Average';
    ELSE
    SET salary_level = 'High';
    END IF;
    
    RETURN salary_level;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE usp_get_employees_by_salary_level(salary_level VARCHAR(7))
BEGIN
	SELECT first_name, last_name FROM employees e
    WHERE salary_level = (SELECT ufn_get_salary_level(e.salary))
    ORDER BY first_name DESC, last_name DESC;
END$$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50))
RETURNS TINYINT
DETERMINISTIC
BEGIN
	DECLARE output TINYINT;
    SET output = (SELECT word REGEXP CONCAT("^[", set_of_letters, "]+$") AS result);
    RETURN output;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE usp_get_holders_full_name()
BEGIN
	SELECT CONCAT(first_name, " ", last_name) AS full_name FROM account_holders e
    ORDER BY full_name, id;
END$$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION ufn_calculate_future_value(sum DECIMAL(12, 4), y_interest_rate DOUBLE(12, 4), number_of_years INT)
RETURNS DECIMAL(12, 4)
DETERMINISTIC
BEGIN
    RETURN (SELECT sum * POW(1+y_interest_rate, number_of_years));
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE usp_calculate_future_value_for_account(acc_id INT, interest_rate DECIMAL(12, 4))
BEGIN
	SELECT a.id AS account_id, first_name, last_name, balance AS current_balance,  
    ufn_calculate_future_value(balance, interest_rate, 5) AS balance_in_5_years
	FROM accounts a
    JOIN account_holders ac
    ON a.account_holder_id = ac.id
    WHERE a.id = acc_id;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE usp_deposit_money(account_id INT, money_amount DECIMAL(12, 4))
BEGIN
	START TRANSACTION;
    IF(money_amount <= 0 OR (SELECT COUNT(*) FROM accounts WHERE id = account_id) = 0) THEN
		ROLLBACK;
	ELSE 
		UPDATE accounts SET balance = balance + money_amount
        WHERE id = account_id;
        COMMIT;
	END IF;
    
    -- SELECT a.id AS account_id, ac.id AS account_holder_id, a.balance
    -- FROM accounts a
    -- JOIN account_holders ac
    -- ON a.account_holder_id = ac.id
    -- WHERE a.id = account_id;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE usp_withdraw_money(account_id INT, money_amount DECIMAL(12, 4))
BEGIN
	START TRANSACTION;
    IF(money_amount <= 0 OR (SELECT COUNT(*) FROM accounts WHERE id = account_id) = 0 OR 
    (SELECT balance FROM accounts WHERE id = account_id) < money_amount) THEN
		ROLLBACK;
	ELSE 
		UPDATE accounts SET balance = balance - money_amount
        WHERE id = account_id;
        COMMIT;
	END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE usp_transfer_money(from_account_id INT, to_account_id INT, amount DECIMAL(19,4))
BEGIN
    START TRANSACTION;
    IF ((SELECT COUNT(*) FROM accounts WHERE id = from_account_id) <> 1 OR
        (SELECT COUNT(*) FROM accounts WHERE id = to_account_id) <> 1 OR
        (SELECT balance FROM accounts WHERE id = from_account_id) < amount OR
        (SELECT balance FROM accounts WHERE id = to_account_id) < amount) THEN
        ROLLBACK;
    ELSE
        CALL usp_deposit_money(to_account_id, amount);
        CALL usp_withdraw_money(from_account_id, amount);
        COMMIT;
    END IF;
END$$
DELIMITER ;

CALL usp_transfer_money(2, 1, 54);