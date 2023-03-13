# MySQL UNION and column alias examples
SELECT firstname, lastname
FROM employees
UNION
SELECT contactfirstname, contactlastname
from customers;

####### //////////////////////###################ALTER


SELECT
	concat(firstname," ", lastname) fullname,
    '////EMP////' as contacttype
FROM employees
UNION SELECT
	concat(contactfirstname ," ", contactlastname),
    '$$$$CUS$$$$' as contacttype
FROM customers
ORDER BY fullname;

# Emulating INTERSECT in MySQL
-- Unfortunately, MySQL does not support the INTERSECT operator.
-- However, you can emulate the INTERSECT operator.

#1) Emulate INTERSECT using DISTINCT and INNER JOIN clause
-- The following statement uses DISTINCT operator 
-- and INNER JOIN clause to return the distinct rows in both tables:

#2) Emulate INTERSECT using IN and subquery
-- The following statement uses the IN operator 
-- and a subquery to return the intersection of the two result sets.


#MySQL MINUS operator emulation
-- Unfortunately, MySQL does not support MINUS operator. 
-- However, you can use join to emulate it.
-- To emulate the MINUS of two queries, you use the following syntax:





















