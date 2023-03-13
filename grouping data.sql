# Introduction to MySQL GROUP BY clause

SELECT status
FROM orders
GROUP BY status;

# B) Using MySQL GROUP BY with aggregate functions

SELECT status, count(*)
from orders
GROUP BY status;

select status , sum(quantityOrdered * priceeach ) AS amount
FROM orders INNER JOIN orderdetails USING(ordernumber)
GROUP BY status;

#C) MySQL GROUP BY with expression example

select year(orderdate) AS years,
SUM(quantityordered * priceeach)
FROM orders INNER JOIN orderdetails USING (ordernumber)
where status = "shipped"
GROUP BY years;

# D) Using MySQL GROUP BY with HAVING clause example

SELECT year(orderdate) AS years ,
SUM(quantityordered * priceeach)
from orders INNER JOIN orderdetails USING (ordernumber)
where status = "shipped"
GROUP BY years
HAVING years > 2003;

# Introduction to MySQL HAVING clause

SELECT ordernumber, sum(quantityordered) AS itemscount,
sum(priceeach * quantityordered) AS total
FROM orderdetails
GROUP BY orderNumber
HAVING total > 1000 AND itemscount >600;

SELECT a.ordernumber, status , sum(priceeach* quantityordered) total
from orderdetails a INNER JOIN orders b using(ordernumber)
-- where status = "shipped"
GROUP BY orderNumber
HAVING status = "shipped" AND total > 1500; 

# MySQL ROLLUP

# Setting up a sample table
create TABLE sales
SELECT productline, YEAR(orderdate) orderyear,
sum(quantityordered * priceeach) ordervalue
from orderdetails INNER JOIN orders USING(ordernumber)
INNER JOIN products USING (productcode)
GROUP BY productLine , year(orderdate);

select *  from sales;

SELECT productline, sum(ordervalue) totalordervalue
FROM sales
GROUP BY productline WITH ROLLUP;

SELECT productline, orderyear , sum(ordervalue) totalordervalue
FROM sales
GROUP BY productline, orderyear WITH ROLLUP;

SELECT orderyear, productline, sum(ordervalue) totalordervalue
FROM sales
GROUP BY orderyear , productline WITH ROLLUP;

#The GROUPING() function

-- We often use GROUPING() function to substitute 
-- meaningful labels for super-aggregate NULL values
-- instead of displaying it directly.

-- The following example shows how to combine 
-- the IF() function with the GROUPING() function to
-- substitute labels for the super-aggregate
-- NULL values in orderYear and productLine columns:

SELECT 
if(GROUPING(orderyear),'ALL YEARS',orderyear) orderyear,
     if(GROUPING(productline),"ALL PRODUCT LINES",productline) productline,
sum(ordervalue)totalordervalue
FROM sales
GROUP BY orderyear,productline WITH ROLLUP;






































