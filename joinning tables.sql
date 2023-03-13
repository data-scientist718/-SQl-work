 #MySQL alias for columns
 
 SELECT concat_ws(", " , lastname , firstname) AS fullname
 FROM employees;
 
 # In MySQL, you can use the column alias in the ORDER BY, 
 # GROUP BY and HAVING clauses to refer to the column.
 
 SELECT concat_ws(", " , lastname , firstname) AS fullname
 FROM employees
 ORDER BY fullname;
 
 # The following statement selects the orders whose total amount is greater than 60000.
 # It uses column aliases in GROUP BY and HAVING clauses.
 select * from orderdetails;
 SELECT orderNumber 'order no.',
 SUM(priceeach * quantityordered) AS total
 FROM orderdetails
 GROUP BY 'order no.'
 HAVING total > 60000;
 
 # MySQL alias for tables
 
SELECT
	customerName,
	COUNT(o.orderNumber) total
FROM
	customers c
INNER JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY
	customerName
ORDER BY
	total DESC; 
 
# Introduction to MySQL join clauses
CREATE TABLE members (member_id INT AUTO_INCREMENT,
name VARCHAR(100),PRIMARY KEY (member_id));

CREATE TABLE committees (committee_id INT AUTO_INCREMENT,
name VARCHAR(100),PRIMARY KEY (committee_id));

INSERT INTO members(name)
VALUES('John'),('Jane'),('Mary'),('David'),('Amelia');

INSERT INTO committees(name)
VALUES('John'),('Mary'),('Amelia'),('Joe');

SELECT * from members;

SELECT * FROM committees;

 #  MySQL INNER JOIN clause
 
 SELECT m.member_id , m.name AS member,
 c.committee_id , c.name AS committee
 from members m inner join committees c ON m.name = c.name;
 
 SELECT productcode,productname,textdescription
 from products t1 INNER JOIN productlines t2
 ON t1.productLine = t2.productLine;
 
 #MySQL INNER JOIN with GROUP BY clause example
 
 select* from orders;
 
SELECT t1.ordernumber,t1.status, sum(quantityordered * priceeach) total
FROM orders t1 INNER JOIN orderdetails t2
ON t1.ordernumber = t2.ordernumber
GROUP BY ordernumber;

#MySQL INNER JOIN – join three tables example

SELECT ordernumber , orderdate , orderlinenumber, productname,
quantityordered , priceeach
FROM orders INNER JOIN orderdetails USING (ordernumber)
INNER JOIN products USING(productcode)
ORDER BY orderNumber , orderLineNumber;

#MySQL INNER JOIN using other operators

SELECT ordernumber, productname , msrp , priceeach
FROM products p INNER JOIN orderdetails o
ON p.productCode = o.productCode
AND p.MSRP > o.priceEach
WHERE p.productCode = "S10_1678";

# MySQL LEFT JOIN


# 1) Using MySQL LEFT JOIN clause to join two tables

SELECT customers. customerNumber, customername ,ordernumber,status
FROM customers LEFT JOIN orders
ON orders.customerNumber = customers.customerNumber;

# 2) Using MySQL LEFT JOIN clause to find unmatched rows

SELECT c.customernumber, c.customername , o.ordernumber,o.status
from customers c LEFT JOIN orders o
ON c.customerNumber= o.customerNumber
where orderNumber IS NULL;

#3) Using MySQL LEFT JOIN to join three tables

SELECT lastname , firstname , customername , checknumber , amount
from employees LEFT JOIN customers
On employeeNumber = salesRepEmployeeNumber
LEFT JOIN payments ON payments.customerNumber = customers.customerNumber
ORDER BY customers.customerName ,customers.customerNumber;

DESCRIBE orders;

# Condition in WHERE clause vs. ON clause

SELECT o.ordernumber, customernumber , productcode
FROM orders o LEFT JOIN orderdetails using(ordernumber)
WHERE orderNumber = 10123;

SELECT o.ordernumber, customernumber, productcode
FROM orders o LEFT JOIN orderdetails d
ON o.orderNumber = d.orderNumber
AND o.orderNumber = 10123;

# Introduction to MySQL RIGHT JOIN clause

SELECT employeenumber , customernumber
FROM customers right JOIN employees
ON salesRepEmployeeNumber = employeeNumber
ORDER BY employeeNumber;

# 2) Using MySQL RIGHT JOIN to find unmatching rows

SELECT employeenumber , customernumber
FROM customers RIGHT JOIN employees
ON salesRepEmployeeNumber = employeeNumber
where customerNumber IS NULL
ORDER BY employeeNumber;

# 1) MySQL self join using INNER JOIN clause

SELECT concat(m.lastname ,", " ,m.firstname)AS Manager,
concat(d.lastname, ", " , d.firstname)AS directreport
FROM employees d INNER JOIN employees m
ON m.employeeNumber = d.reportsTo
ORDER BY manager;

# 2) MySQL self join using LEFT JOIN clause

SELECT IFNULL(CONCAT(m.lastname, ", " , m.firstname),
"Top Manager") AS "MAnager" ,
concat(e.lastname, ", " , e.firstname) as "direct report"
FROM employees e LEFT JOIN employees m
ON m.employeeNumber = e. reportsTo
ORDER BY manager desc;

# 3) Using MySQL self join to compare successive rows

SELECT c1.city , c1.customername , c2.customername
FROM customers c1 INNER JOIN customers c2
ON c1.city = c2.city AND c1.customerName > c2.customerName
ORDER BY c1.city;

# Introduction to MySQL CROSS JOIN clause

SELECT * FROM t1
CROSS JOIN t2;

SELECT * FROM t1
CROSS JOIN t2
WHERE t1.id = t2.id;





























 
 



 
 
 
 
 
 
 
 
 
 
 