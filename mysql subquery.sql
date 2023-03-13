# MySQL Subquery

select customernumber , checknumber , amount
FROM payments
WHERE amount > (SELECT avg(amount) FROM payments);

SELECT customername
FROM customers
WHERE customerNumber NOT IN (SELECT DISTINCT customerNumber
FROM orders);

# MySQL subquery in the FROM clause

SELECT MAX(items), MIN(items), floor(avg(items))
FROM (SELECT ordernumber, count(ordernumber) AS items
FROM orderdetails GROUP BY orderNumber) AS lineitems;

SELECT productname , buyprice
FROM products p1
WHERE buyPrice > (SELECT avg(buyPrice) FROM products
WHERE productLine = p1.productLine);

SELECT customernumber, customername
FROM customers
where 
EXISTS
     (SELECT ordernumber , SUM(priceeach * quantityordered)
      FROM orderdetails INNER JOIN orders USING (ordernumber)
      where
		customerNumber= customers.customerNumber
        
	  GROUP BY ordernumber
      HAVING sum(priceEach * quantityOrdered) > 60000);


















