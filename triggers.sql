############# TRIGERS ########################

# MySQL BEFORE INSERT Trigger
USE classicmodels;

# MySQL BEFORE INSERT trigger example



CREATE TABLE WORKCENTERS(id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL, capacity INT NOT NULL);

CREATE TABLE WorkCenterStatus(totalcapacity INT NOT NULL);

-- The following trigger updates the total capacity in the WorkCenterStats table before a 
-- new work center is inserted into the WorkCenter table:

DELIMITER $$

CREATE TRIGGER before_workcenters_insert
BEFORE INSERT ON WORKCENTERS FOR EACH ROW
BEGIN
	DECLARE rowcount INT;
    
    SELECT count(*)
    INTO rowcount
    FROM WORKCENTERS;
    
    IF rowcount > 0 THEN
		UPDATE WorkCenterStatus
        SET totalcapacity= totalcapacity + new.capacity;
	ELSE
		INSERT INTO WorkCenterStatus(totalcapacity)
        VALUES(new.capacity);
	END IF;

END $$
    
DELIMITER ;  

DROP TRIGGER before_workcenters_insert;

INSERT INTO WORKCENTERS(name, capacity)
VALUES('Mold Machine',100);


select * from WorkCenterStatus;

INSERT INTO WORKCENTERS(name, capacity)
VALUES('Packing',200);

SELECT * FROM WORKCENTERS;


############ MySQL AFTER INSERT Trigger ##########

DROP TABLE IF EXISTS members;

CREATE TABLE members (
    id INT AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255),
    birthDate DATE,
    PRIMARY KEY (id)
);

CREATE TABLE reminders (
    id INT AUTO_INCREMENT,
    memberId INT,
    message VARCHAR(255) NOT NULL,
    PRIMARY KEY (id , memberId)
);

##### Creating AFTER INSERT trigger example

DELIMITER $$

CREATE TRIGGER after_member_insert
AFTER INSERT ON members FOR EACH ROW

BEGIN
	IF new.birthdate IS NULL THEN
    INSERT INTO reminders(memberid, message)
    VALUES(new.id,concat('hi', new.name,', please update your DAte of birth'));
    
    END IF;
    
END $$
    
DELIMITER ;

 
INSERT INTO members(name, email, birthDate)
VALUES
    ('John Doe', 'john.doe@example.com', NULL),
    ('Jane Doe', 'jane.doe@example.com','2000-01-01');
    
SELECT * FROM members;

SELECT * from reminders;

    
    
    
    
    
    
    
    
    
    
    



















