
#Getting started with stored procedures
use classicmodels;
show tables;

SELECT customername, city , state , postalcode,country
FROM customers
ORDER BY customername;


# we are going to create procedure which run this whole code by calling it
DELIMITER $$
CREATE PROCEDURE GetCustomers()
BEGIN
SELECT customername, city , state , postalcode,country
FROM customers
ORDER BY customername;
END$$
DELIMITER ;

# we are going to call this function

call GetCustomers();

# MySQL Stored Procedure Variables

DELIMITER //
CREATE PROCEDURE GEtTotalOrder()
BEGIN
DECLARE totalorder INT DEFAULT 0;
SELECT COUNT(*)
INTO totalorder
FROM orders;
SELECT totalorder;
END //
DELIMITER ;

call GEtTotalOrder();

USE classicmodels;

# MySQL stored procedure parameter examples

 --  The IN parameter example-- 
DELIMITER //

CREATE PROCEDURE GetOfficebyCountry(IN countryname
VARCHAR (255))
BEGIN
		SELECT * FROM offices WHERE country = countryname;
END //

DELIMITER ;

CALL getofficebycountry('USA');

CALL getofficebycountry('france');

# The OUT parameter example

DELIMITER //

CREATE PROCEDURE GetOrderCountByStatus( IN orderstatus VARCHAR(255)
, out total INT)
BEGIN
		SELECT count(ordernumber)
        INTO total
        FROM orders
        WHERE status = orderstatus;
END //
DELIMITER ;

CALL getordercountbystatus('shipped',@total);
SELECT @total;

CALL getordercountbystatus("in process",@total);

SELECT @total AS total_in_process;

# The INOUT parameter example

DELIMITER $$

CREATE PROCEDURE setcounter(INOUT counter INT,IN inc INT)
BEGIN
		SET counter = counter = inc;
END $$
DELIMITER ;

SET @counter = 1;
CALL SetCounter(@counter,1); -- 2
CALL SetCounter(@counter,1); -- 3
CALL SetCounter(@counter,5); -- 8
SELECT @counter; -- 8



# Listing Stored Procedures

SHOW PROCEDURE STATUS;

# SHOW PROCEDURE STATUS WHERE search_condition;

SHOW PROCEDURE STATUS WHERE db = "classicmodels";

# The following statement shows all stored procedure whose names contain the wordOrder:

SHOW PROCEDURE STATUS LIKE '%order%';

# Listing stored procedures using the data dictionary

SELECT routine_name
FROM information_schema.routines
WHERE routine_type ='PROCEDURE' AND routine_schema = 'classicmodels';

#################### MySQL IF Statement ###############

# MySQL simple IF-THEN statement

DELIMITER $$

CREATE PROCEDURE GetCustomerLevel(
	IN pcustomernumber INT,
    OUT pcustomerlevel VARCHAR(20))
BEGIN
	DECLARE credit DECIMAL(10,2) DEFAULT 0;
    
    SELECT creditlimit
    INTO credit
    FROM customers
    WHERE  customernumber = pcustomernumber;
    
    IF credit > 50000 THEN
		SET pcustomerlevel = 'PLATINUM';
        
	END IF;
END $$

DELIMITER ;
    
# These statements call the GetCustomerLevel() stored procedure for 
#customer 141 and show the value of the OUT parameter pCustomerLevel:
    
CALL GetCustomerLevel(141, @level);
SELECT @level AS customer_level;    

################# MySQL IF-THEN-ELSE statement ################


DROP PROCEDURE getcustomerlevel;

DELIMITER $$

CREATE PROCEDURE GetCustomerLevel(
	IN pcustomernumber int,
    OUT pcustomerlevel VARCHAR(25))
    
BEGIN
    DECLARE credit DECIMAL DEFAULT 0;
    SELECT creditlimit
    INTO credit
    FROM customers
    WHERE customernumber = pcustomernumber;
    
    if credit > 50000 THEN
		set pcustomerlevel = "PLATINUM";
    ELSE 
		SET pcustomerlevel = "NOTPLATINUM";
	END IF;
END$$

DELIMITER ;

CALL Getcustomerlevel (447, @level);
select @level;
    
# MySQL IF-THEN-ELSEIF-ELSE statement    

DELIMITER //

CREATE PROCEDURE GetCustomerLevel(
	IN pcustomernumber INT,
    OUT pcustomerlevel VARCHAR(25))
BEGIN
	DECLARE credit DECIMAL DEFAULT 0;
    SELECT creditlimit
    INTO credit
    FROM customers
    WHERE customernumber = pcustomernumber;
    
    if credit > 50000 THEN
		SET pcustomerlevel = "PLATINUM";
	ELSEIF credit BETWEEN 10000 AND 50000 THEN
		SET pcustomerlevel = "Gold";
	ELSE 
		SET pcustomerlevel = "silver";
	END IF;
END//
DELIMITER ;

CALL GetCustomerLevel(125,@level);
SELECT @level;

# MySQL CASE Statement

# Simple CASE statement

DELIMITER $$

CREATE PROCEDURE GetCustomerShipping(
	IN  pCustomerNUmber INT, 
	OUT pShipping VARCHAR(50)
)
BEGIN
    DECLARE customerCountry VARCHAR(100);

SELECT 
    country
INTO customerCountry FROM
    customers
WHERE
    customerNumber = pCustomerNUmber;

    CASE customerCountry
		WHEN  'USA' THEN
		   SET pShipping = '2-day Shipping';
		WHEN 'Canada' THEN
		   SET pShipping = '3-day Shipping';
		ELSE
		   SET pShipping = '5-day Shipping';
	END CASE;
END$$

DELIMITER ;
############# LOOPS #######################

# MySQL LOOP statement example

USE classicmodels;

DELIMITER $$

CREATE PROCEDURE loopdemo()

BEGIN
		DECLARE x INT;
        DECLARE str VARCHAR(255);
        
        SET x = 1;
        SET str = '';
        loop_label: LOOP
				IF x > 10 then
						LEAVE loop_label;
				END IF;
                
                SET x = x + 1;
                IF (x MOD 2) THEN
						ITERATE loop_label;
				ELSE
						SET str = concat(str , x , ',');
				END IF;
		END LOOP;
        SELECT str;
END $$
DELIMITER ;

# call the loop function;

CALL loopdemo();

###############  MySQL WHILE Loop     ######################

# MySQL WHILE loop statement example

CREATE TABLE calendars(
    id INT AUTO_INCREMENT,
    fulldate DATE UNIQUE,
    day TINYINT NOT NULL,
    month TINYINT NOT NULL,
    quarter TINYINT NOT NULL,
    year INT NOT NULL,
    PRIMARY KEY(id)
);

DELIMITER $$

CREATE PROCEDURE InsertCalendar(dt DATE)
BEGIN
    INSERT INTO calendars(
        fulldate,
        day,
        month,
        quarter,
        year
    )
    VALUES(
        dt, 
        EXTRACT(DAY FROM dt),
        EXTRACT(MONTH FROM dt),
        EXTRACT(QUARTER FROM dt),
        EXTRACT(YEAR FROM dt)
    );
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE LoadCalendars(
    startDate DATE, 
    day INT
)
BEGIN
    
    DECLARE counter INT DEFAULT 1;
    DECLARE dt DATE DEFAULT startDate;

    WHILE counter <= day DO
        CALL InsertCalendar(dt);
        SET counter = counter + 1;
        SET dt = DATE_ADD(dt,INTERVAL 1 day);
    END WHILE;

END$$

DELIMITER ;

CALL LoadCalendars('2019-01-01',31);
















































    
    
    
    
    
    































