show databases;
use classicmodels;
show tables;
select * from employees;

#1 First we use the where clause aloow you to specify search condition
#for the row returned by the query.

select firstname , lastname , jobtitle
from employees
where jobtitle = "sales rep";

#2 using where clause with AND operator

select lastname , firstname , jobtitle , officecode
from employees
where jobtitle = "sales rep" AND officecode = 1;

#3 using where clause with OR operator

select lastname , firstname , jobtitle , officecode
from employees
where jobtitle = "sales rep" OR officecode = 1;

# 4) Using MySQL WHERE clause with the BETWEEN operator example

select lastname , firstname, officecode
from employees 
where officecode  between 1 and 3
order by officecode;
#5) Using MySQL WHERE clause with the LIKE operator example
-- The LIKE operator evaluates to TRUE if a value matches a specified pattern.

-- To form a pattern, you use the % and _ wildcards.
-- The % wildcard matches any string of zero or more characters 
-- while the _ wildcard matches any single character.

SELECT lastname , firstname
FROM employees
WHERE lastname LIKE '%son'
order by firstname;

#6) Using MySQL WHERE clause with the IN operator example

SELECT firstname , lastname , officecode
FROM employees
where officecode IN (1,2,3)
ORDER BY officecode;

#7) Using MySQL WHERE clause with the IS NULL operator

SELECT lastname , firstname , reportsto
FROM employees
WHERE reportsto IS NULL;

#8) Using MySQL WHERE clause with comparison operators

SELECT lastname , firstname , jobtitle
FROM employees
WHERE jobtitle <> "sales rep";

# (B) MySQL DISTINCT clause

SELECT DISTINCT(lastname)
FROM employees
ORDER BY lastname;

# 2) MySQL DISTINCT and NULL values

SELECT DISTINCT state
FROM customers;

# 3) MySQL DISTINCT with multiple columns

SELECT DISTINCT state,city
FROM customers
WHERE state IS NOT NULL
ORDER BY state , city;

# Introduction to the MySQL IN operator

SELECT officecode, city , phone, country
FROM offices
WHERE country IN('USA' , 'france');

# 1) Using MySQL BETWEEN with number examples

SELECT productcode , productname,buyprice
FROM products
WHERE buyprice BETWEEN 90 AND 100;

# 2) Using MySQL BETWEEN operator with dates example

SELECT orderNumber,requiredDate,status
FROM orders
WHERE requireddate BETWEEN 
     CAST('2003-01-01' AS DATE) AND 
     CAST('2003-01-31' AS DATE);
     
# Introduction to MySQL LIKE operator
-- Use the LIKE operator to test if a value matches a pattern.
-- The % wildcard matches zero or more characters.
-- The _ wildcard matches a single character.
-- Use ESCAPE clause specifies an escape character other than the default escape character (\).
-- Use the NOT operator to negate the LIKE operator.

# Introduction to MySQL LIMIT clause

SELECT customernumber, customername , creditlimit
FROM customers
ORDER BY creditlimit DESC
LIMIT 5;

# MySQL IS NULL – specialized features

# 1) Treatment of date ‘0000-00-00’

#2) Influence of @@sql_auto_is_null variable































































