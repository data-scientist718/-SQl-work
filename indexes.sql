

################## MySQL CREATE INDEX  ######################


SELECT employeenumber,lastname,firstname
FROM employees
WHERE jobTitle = 'sales rep';

CREATE INDEX jobtitle ON employees(jobtitle);

EXPLAIN SELECT employeenumber,lastname,firstname
FROM employees
WHERE jobTitle = 'sales rep';

SHOW INDEXES FROM employees;












