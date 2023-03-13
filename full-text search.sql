

####### Creating FULLTEXT Indexes for Full-Text Search ####

-- The following statement creates a new table
--  named posts that has a FULLTEXT index
--  that includes the post_content column.

CREATE TABLE posts (
  id INT NOT NULL AUTO_INCREMENT,
  title VARCHAR(255) NOT NULL,
  body TEXT,
  PRIMARY KEY (id),
  FULLTEXT KEY (body )

);

describe posts;


### Create FULLTEXT index using ALTER TABLE statement

describe products;

ALTER TABLE products
ADD FULLTEXT(productdescription,productline);

### Create FULLTEXT index using CREATE INDEX statement##

DESCRIBE offices;

CREATE FULLTEXT INDEX address
ON offices(addressline1,addressline2);

###### Drop a FULLTEXT index ####

ALTER TABLE offices
DROP INDEX address;

DESCRIBE offices;


#### MySQL Natural Language Full-Text Searches##

## MySQL natural language full-text search example

ALTER TABLE products
ADD FULLTEXT(productline);

SELECT productname, productline
FROM products 
WHERE MATCH(productline)
AGAINST('classic');

SELECT productname, productline 
FROM products
WHERE MATCH (productline)
AGAINST('classic,vintage')
ORDER BY productname;

###### MySQL Boolean Full-Text Searches##

ALTER TABLE products 
ADD FULLTEXT(productName);

select productname,productline
FROM products
WHERE MATCH (productname)
AGAINST('truck' IN BOOLEAN MODE);

-- you can use the exclude Boolean operator ( - ), 
-- which returns the result 
-- that excludes the Pickup keyword as the following query:

SELECT productname,productline
FROM products
WHERE MATCH (productname)
AGAINST('truck -pickup' IN BOOLEAN MODE);

##### MySQL query expansion example########

SELECT productname
FROM products
WHERE MATCH (productname)
AGAINST('1992' );

SELECT productname
FROM products
WHERE MATCH (productname)
AGAINST('1992' WITH QUERY EXPANSION);









