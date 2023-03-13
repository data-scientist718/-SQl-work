
################# MSQL CREATE VIEW ####################

##### 3) Creating a view with join example#333

CREATE VIEW customerorders AS
SELECT ordernumber , customername,sum(quantityordered * priceeach)total
FROM orderdetails
INNER JOIN orders o USING (ordernumber)
INNER JOIN customers USING ( customernumber)
GROUP BY orderNumber;

SELECT * from  customerorders
ORDER BY total DESC;

##### 4) Creating a view with a subquery example ###

CREATE VIEW aboveavgproducts AS
SELECT productcode, productname,buyprice
FROM products
WHERE buyprice > (SELECT avg(buyPrice) FROM products)
ORDER BY buyPrice DESC;

SELECT * FROM aboveavgproducts;

#### 5) Creating a view with explicit view columns example#

CREATE VIEW customerorderstatus(customername,ordercount)
AS SELECT customername,count(ordernumber)
FROM customers INNER JOIN orders USING(customernumber)
GROUP BY customername;

SELECT * FROM customerorderstatus
ORDER BY ordercount;

######## MySQL View Processing Algorithms ############


######### MERGE #################33


CREATE ALGORITHM=MERGE VIEW contactpersons(customername,
firstname,lastname,phone) AS
SELECT customername,contactfirstname,contactlastname,phone
FROM customers;

SELECT * FROM contactpersons
WHERE customername LIKE '%Co%';

### MySQL updatable view example ####

CREATE VIEW officeinfo
AS 
SELECT officecode, phone, city
FROM offices;

select * from officeinfo;

UPDATE officeinfo
SET 	phone = '+33 14 723 5555'
WHERE officecode = 4;

select * FROM officeinfo
WHERE officecode = 4;

SELECT 
    table_name, 
    is_updatable
FROM
    information_schema.views
WHERE
    table_schema = 'classicmodels';
    
    ######### Removing rows through the view########33
    
   -- create a new table named items
CREATE TABLE items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(11 , 2 ) NOT NULL
);

-- insert data into the items table
INSERT INTO items(name,price) 
VALUES('Laptop',700.56),('Desktop',699.99),('iPad',700.50) ;

-- create a view based on items table

CREATE VIEW luxuryitems AS
SELECT * FROM items
WHERE price > 700;
 
   -- query data from the LuxuryItems view
   
SELECT * FROM luxuryitems;

# second we delete the itme in lxuary item

DELETE FROM luxuryitems
WHERE id = 3;

select * FROM luxuryitems;


select * from items;

#######Understanding LOCAL & CASCADED in WITH CHECK OPTION Clause######



















