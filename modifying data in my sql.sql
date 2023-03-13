
# MySQL INSERT INTO SELECT

#MySQL INSERT INTO SELECT example

CREATE TABLE suppliers (
    supplierNumber INT AUTO_INCREMENT,
    supplierName VARCHAR(50) NOT NULL,
    phone VARCHAR(50),
    addressLine1 VARCHAR(50),
    addressLine2 VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    postalCode VARCHAR(50),
    country VARCHAR(50),
    customerNumber INT,
    PRIMARY KEY (supplierNumber)
);
-- Suppose all customers from California, USA become the 
-- company’s suppliers.The following query finds 
-- all customers who locate in California, USA:

SELECT customerNumber,customerName,phone,addressLine1,addressLine2,
city,state,postalCode,country
FROM
    customers
WHERE
    country = 'USA' AND 
    state = 'CA';
    
-- Second, use the INSERT INTO ... SELECT statement to insert
--  customers who locate in California USA from 
--  the  customers table into the  suppliers table:
    
    
INSERT INTO suppliers (supplierName, phone, addressLine1,addressLine2,
city,state,postalCode,country,customerNumber)
SELECT customerName,phone,addressLine1,addressLine2,city,state ,
postalCode,country,customerNumber
FROM 
    customers
WHERE 
    country = 'USA' AND 
    state = 'CA';
    
SELECT * FROM suppliers;   

#################################3

show DATABASES;
USE classicmodels;
SHOW TABLES;

#mysql update example

SELECT firstname , lastname , email
FROM employees
WHERE employeenumber = 1056;

#Second, update the email address of Mary to the new email

UPDATE employees
SET email = "marry.patterson@classicmodelcars.com"
WHERE employeenumber = 1056;

# Third,  execute the SELECT statement again to verify the change:

SELECT firstname , lastname , email
FROM employees
WHERE employeenumber = 1056;

#2) Using MySQL UPDATE to modify values in multiple columns
UPDATE employees
SET lastname = "hill" , email = "marry.hill@classicmodelcars.com"
WHERE employeenumber = 1056;

#Let’s verify the changes:
SELECT firstname , lastname , email
from employees
where employeenumber = 1056;
###############3####################################
#MySQL UPDATE JOIN syntax
##############3333#######################
CREATE DATABASE IF NOT EXISTS empdb;

USE empdb;

-- create tables
CREATE TABLE merits (performance INT(11) NOT NULL,
percentage FLOAT NOT NULL,PRIMARY KEY (performance));

CREATE TABLE employees (emp_id INT(11) NOT NULL AUTO_INCREMENT,
emp_name VARCHAR(255) NOT NULL,performance INT(11) DEFAULT NULL,
salary FLOAT DEFAULT NULL,PRIMARY KEY (emp_id),
CONSTRAINT fk_performance FOREIGN KEY (performance)
REFERENCES merits (performance)
);
-- insert data for merits table
INSERT INTO merits(performance,percentage)
VALUES(1,0),
      (2,0.01),
      (3,0.03),
      (4,0.05),
      (5,0.08);
-- insert data for employees table
INSERT INTO employees(emp_name,performance,salary)      
VALUES('Mary Doe', 1, 50000),
      ('Cindy Smith', 3, 65000),
      ('Sue Greenspan', 4, 75000),
      ('Grace Dell', 5, 125000),
      ('Nancy Johnson', 3, 85000),
      ('John Doe', 2, 45000),
      ('Lily Bush', 3, 55000);


# MySQL UPDATE JOIN example with INNER JOIN clause

UPDATE employees
		INNER JOIN
	merits ON employees.performance = merits.performance
SET salary = salary +salary * percentage;

SELECT * from employees;

# MySQL UPDATE JOIN example with LEFT JOIN

INSERT INTO employees(emp_name,performance,salary)
VALUES('Jack William',NULL,43000),
      ('Ricky Bond',NULL,52000);

UPDATE employees
		LEFT JOIN
	merits ON employees.performance = merits.performance
SET
	salary = salary +salary * 0.015
WHERE
	merits.percentage IS NULL;
      
SELECT * from merits;
 
# introduction to MySQL DELETE statement 

DELETE FROM employees
where performance = 1;

select * from employees;

-- DELETE FROM table_name
-- ORDER BY c1, c2, ...
-- LIMIT row_count;  
    
# MySQL DELETE JOIN with INNER JOIN example

DROP TABLE IF EXISTS t1, t2;

CREATE TABLE t1 (
    id INT PRIMARY KEY AUTO_INCREMENT
);

CREATE TABLE t2 (
    id VARCHAR(20) PRIMARY KEY,
    ref INT NOT NULL
);

INSERT INTO t1 VALUES (1),(2),(3);

INSERT INTO t2(id,ref) VALUES('A',1),('B',2),('C',3);

select * FROM t1;

select * from t2;


DELETE t1,t2
FROM t1 INNER JOIN t2 ON t2.ref = t1.id
where t1.id =1;

# on delete cascade

CREATE TABLE buildings (
    building_no INT PRIMARY KEY AUTO_INCREMENT,
    building_name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL
);

CREATE TABLE rooms (
    room_no INT PRIMARY KEY AUTO_INCREMENT,
    room_name VARCHAR(255) NOT NULL,
    building_no INT NOT NULL,
    FOREIGN KEY (building_no)
        REFERENCES buildings (building_no)
        ON DELETE CASCADE
);

INSERT INTO buildings(building_name,address)
VALUES('ACME Headquaters','3950 North 1st Street CA 95134'),
      ('ACME Sales','5000 North 1st Street CA 95134');
    
INSERT INTO rooms(room_name,building_no)
VALUES('Amazon',1),
      ('War Room',1),
      ('Office of CEO',1),
      ('Marketing',2),
      ('Showroom',2);
      
select * from buildings;

select * from rooms;


DELETE FROM buildings
where building_no=2;

select * FROM rooms;

# Tips to find tables affected by MySQL ON DELETE CASCADE action

USE information_schema;
SELECT buildings
FROM referential_constraints
WHERE
	constraint_schema = 'empdb'
		AND referenced_table_name = 'buildings'
        AND delete_rule = 'CASCADE';
        
# MySQL REPLACE

 CREATE TABLE cities (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    population INT NOT NULL
);
 
INSERT INTO cities(name,population)
VALUES('New York',8008278),
	  ('Los Angeles',3694825),
	  ('San Diego',1223405);
        
        
SELECT * FROM  cities;

REPLACE INTO cities(id,name,population)
VALUE(3,'ali',1223408);

select * from cities;

REPLACE INTO cities 
SET id = 4, name = 'phoenix', population = 1768980;
        
select * from cities;

# MySQL prepared statement usage

use classicmodels;

#First, prepare a statement that returns the product code and 
#name of a product specified by product code:

PREPARE stmt1 FROM
'SELECT productcode, productname FROM products
WHERE productcode = ?';

#Second, declare a variable named pc, stands for product code, 
#and set its value to 'S10_1678':

SET @pc = 'S10_1678';

# Third, execute the prepared statement:

EXECUTE stmt1 USING @pc;

# Fourth, assign the pc variable another product code:
SET @pc = 'S12_1099';

EXECUTE stmt1 USING @pc;



        
        
        
        
        
        




    
    
    
    
    
    
    
    