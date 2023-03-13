show DATABASES;

USE HRdatabase;
SHOW TABLES;

######################## [1]  ###########################

SELECT first_name "FIRST NAME" , last_name "LAST NAME"
FROM employees;

##################### [2] #########################

SELECT DISTINCT department_id
FROM employees;

##################### [3] #######################3

SELECT * FROM employees
ORDER BY first_name Desc;

################ [4] ######################

SELECT first_name , last_name,salary ,salary* .15 AS PF
FROM employees;

################# [5]  ###############################3333

SELECT employee_id , first_name , last_name ,salary
FROM employees
ORDER BY salary;

###########################  [6]  ###################

SELECT sum(salary) AS "total salaries"
FROM employees;

################### [7] #####################

SELECT max(salary) maximum, min(salary) minimum
FROM employees;


################ [8] ##############################

SELECT avg(salary) , count(*)
from employees;

############################ [10] ############################

SELECT count(DISTINCT(job_id))
FROM employees;

###################### [11] ########################33

SELECT upper(first_name)
FROM employees;

#################### [12]#######################

SELECT substring(first_name,1,3)
FROM employees;

#################### [14] #########################

SELECT concat(first_name," ",last_name) NAME
FROM employees;

#####################  [15]   ###########################

SELECT first_name, trim(first_name) 
FROM employees;

###################### [16] ##################

SELECT length(first_name) + length(last_name) "length of names"
FROM employees;


###################3 [17] #######################3

SELECT first_name 
FROM employees
WHERE first_name REGEXP '[0-9]';


##################### [18] ###################

SELECT * FROM employees
LIMIT 10;

######################## [19] #########################

select first_name,last_name, round(salary /12 , 2) AS "MONTHLY SALARY"
FROM employees;


#### MySQL Restricting and Sorting data: ###################
###############################[11 exercises with solution]######

###################### [1] ########################33

SELECT first_name , last_name , salary
FROM employees
where salary NOT BETWEEN 10000 AND 15000;

##################3 [2] ##############################33

SELECT first_name , last_name , department_id
FROM employees
WHERE department_id in (30 , 100)
ORDER BY department_id ASC;

####################### [3]  #########################3

SELECT first_name , last_name , salary,department_id
FROM employees
WHERE department_id in (30 , 100) AND salary NOT BETWEEN 10000 AND 15000;


######################  [4]  ##########################

SELECT first_name , last_name, hire_date
FROM employees 
WHERE hire_date LIKE  '1987%';

######################  [5]  #############################

SELECT first_name
FROM employees
WHERE first_name LIKE '%b%' AND first_name LIKE "%c%";

####################  [6]  ############################

SELECT last_name , job_id , salary
FROM employees
where job_id in('IT_PROG' , 'SH_CLERK') AND 
salary NOT IN (4500,10000,15000);

########################## [7] #########################

SELECT last_name
FROM employees
where last_name LIKE '______';

######################### [8] ##############################

SELECT last_name
FROM employees
WHERE last_name LIKE '__e';

######################## [9] ##############################

SELECT DISTINCT job_id FROM employees;


######################### [11] ############################

SELECT * FROM employees
where last_name in('blake','scott', 'king', 'ford');

##################### [7] ##############################33

SELECT job_id, count(*) 
FROM employees
GROUP BY job_id;

####################### [9] ##########################3

select manager_id ,min(salary)
FROM employees
where manager_id is NOT NULL
GROUP BY manager_id
ORDER BY min(salary) DESC;

##################### [10] ##############################

SELECT department_id ,sum(salary) total_salary
FROM employees
GROUP BY department_id;

#######################3 [11] ##############################

SELECT job_id, avg(salary)
FROM employees
WHERE job_id not in ("IT_PROG")
GROUP BY job_id;

####################### [12] ########################33

SELECT job_id , sum(salary) , max(salary) , min(salary), avg(salary)
FROM employees
WHERE department_id = 90
GROUP BY job_id;


#################### [13] ###############################

SELECT job_id , max(salary)
FROM employees
GROUP BY job_id
HAVING max(salary) >= 4000;

###################### [14] #########################

SELECT department_id , avg(salary), count(*)
FROM employees
GROUP BY department_id
HAVING count(*) > 10;

#### MySQL Subquery [22 exercises with solution] ################

select first_name , last_name , salary
FROM employees
WHERE  salary >(SELECT  salary  from employees
where last_name = 'bull');

######################## [2] #####################3

SELECT first_name , last_name 
FROM employees
WHERE department_id IN ( SELECT department_id FROM departments
WHERE department_name ="it");

select* from departments;

######################### [3] ###########################3

select first_name , last_name 
FROM employees
where manager_id IN ( select manager_id from departments
where location_id IN (SELECT location_id FROM locations
WHERE country_id = "US"));

SELECT first_name, last_name FROM employees 
WHERE manager_id in (select employee_id 
FROM employees WHERE department_id 
IN (SELECT department_id FROM departments WHERE location_id 
IN (select location_id from locations where country_id='US')));

#######################  [4] ############################

SELECT first_name , last_name
FROM employees 
WHERE (employee_id IN(SELECT manager_id FROM employees));

SELECT manager_id FROM employees;

############################ [5] ###############################

SELECT first_name , last_name ,salary
FROM employees
WHERE salary > (SELECT avg(salary) FROM employees);

################## [6] ##########################

SELECT first_name , last_name , salary
FROM employees
WHERE employees.salary = (SELECT min_salary from jobs
WHERE employees.job_id = jobs.job_id);

###################### [7] ###############################3

select first_name , last_name  , salary 
FROM employees
where department_id IN (SELECT department_id FROM departments WHERE 
department_name LIKE 'IT%') AND salary > ( SELECT avg(salary) FROM employees);

SELECT first_name, last_name, salary 
FROM employees 
WHERE department_id IN 
(SELECT department_id FROM departments WHERE department_name LIKE 'IT%') 
AND salary > (SELECT avg(salary) FROM employees);

##########################33 [8] ##########################

select first_name , last_name , salary
FROM employees
where salary >
(select salary FROM employees WHERE last_name like "%bell%");

#####################  [9] #############################3
SELECT first_name,last_name , salary
FROM employees WHERE salary =
(SELECT min(salary) FROM employees);

######################## [10] ############################3

SELECT first_name,last_name , salary
FROM employees WHERE salary >
ALL(SELECT avg(salary) FROM employees
GROUP BY department_id);

######################### [11] ############################
SELECT first_name , last_name , salary
FROM employees
where salary >
ALL(select salary FROM employees WHERE job_id = "SH_CLERK")
ORDER BY salary ASC ;

###################### [12] ##############################3

SELECT b.first_name , b.last_name
FROM employees b
WHERE NOT EXISTS(SELECT 'X' FROM employees a
WHERE a.manager_id = b.employee_id);

####################3 [13 #############################3

SELECT employee_id ,first_name , last_name,
(select department_name FROM departments d
where e.department_id = d.department_id) department
FROM employees e ORDER BY department;

################## [14] ####################
SELECT employee_id , first_name, last_name , salary
FROM employees AS A
WHERE salary >
(select avg(salary) from employees WHERE department_id =
A.department_id
);

######################### [15] #######################
SELECT employee_id 
FROM employees
WHERE MOD(employee_id, 2) = 0;

########################## [16] ##################33
SELECT DISTINCT salary
FROM employees
ORDER BY salary DESC
LIMIT 4, 1;

######################3 [17] ########################

SELECT DISTINCT salary
FROM employees
ORDER BY salary ASC
limit 3,1 ;

###################### [18] ######################

SELECT * from employees
ORDER BY employee_id DESC
LIMIT 10 su

SELECT * FROM (
SELECT * FROM employees ORDER BY employee_id DESC LIMIT 10) sub 
ORDER BY employee_id ASC;

###################3 [19] ########################

SELECT department_id , department_name
from departments 
where department_id NOT IN (select department_id  from employees);

################# [20] #########################

SELECT DISTINCT salary
FROM employees
ORDER BY salary DESC
limit 3;

######################## [21] ##############################

SELECT *
FROM employees emp1
WHERE (1) = (
SELECT COUNT(DISTINCT(emp2.salary))
FROM employees emp2
WHERE emp2.salary > emp1.salary);

SELECT * FROM employees
ORDER BY salary DESC
LIMIT 1, 2;

###### MySQL JOINS - Exercises, Practice, Solution ########

###########################3 [1] ##############################3

select location_id, street_address , city , state_province,country_name
from locations NATURAL JOIN countries;

############################# [2] ###############################

select first_name , last_name , department_id , department_name
from employees JOIN departments
USING (department_id);

######################## [3] #################################

select e.first_name , e.last_name ,e.job_id ,e.department_id , d.department_name ,l.city
from employees e JOIN departments d
ON (e.department_id = d.department_id)
JOIN locations l ON (d.location_id = l.location_id)
WHERE lower(l.city) = 'london';

######################### [4] ##############################

SELECT e.employee_id "EMP_ID", e.last_name "Employeer",
m.employee_id "MGR_ID" , m.last_name "MANAGER"
from employees e JOIN
employees m ON(m.manager_id = e.employee_id);

####################### [5] ##############################

SELECT e.first_name , e.last_name , e.hire_date
FROM employees e JOIN
employees d ON (d.last_name = 'jones')
WHERE d.hire_date < e.hire_date;

SELECT first_name , last_name , hire_date
FROM employees
WHERE hire_date > (SELECT hire_date from employees 
WHERE last_name= "jones");

#####################[6] ###########################
select department_name , count(employee_id) AS "NUMBER OF EMPLOYEES"
FROM employees JOIN departments
using (department_id)
GROUP BY department_name
ORDER BY department_name;

###################### [7] ######################

SELECT employee_id , job_title , (end_date - start_date) AS "number_of_days_spent"
FROM jobs
NATURAL JOIN job_history 
where department_id = 90;

########################## [8] ################################

SELECT d.department_id , d.department_name, d.manager_id , e.first_name
FROM employees e JOIN departments d
ON(d.manager_id = e.employee_id);


######################### [9] ###################################

select department_name , concat(first_name," ", last_name) "manager_name" , city
FROM employees JOIN departments
ON departments.manager_id = employees.employee_id
join locations
USING (location_id);

######################## [10] #############################

select avg(salary) , job_title
from employees join jobs
ON employees.job_id = jobs.job_id
GROUP BY job_title
ORDER BY job_title;

############################## [11] ####################################

SELECT job_title , first_name ,salary-min_salary
FROM employees NATURAL JOIN jobs;

######################### [12] ##############################################

select j.* , e.first_name , e.salary
from job_history j JOIN employees e
using (employee_id)
where e.salary > 10000;

############################# [13] ############################

select d.department_name , e.first_name , e.last_name, e.hire_date , e.salary
,(datediff(now() , e.hire_date))/365 Experiences
from departments d JOIN employees e
ON (d.manager_id = e.employee_id)
where (datediff(now() , e.hire_date))/365 > 15;

#####  MySQL Date and Time - Exercises, Practice, Solution ######

############################## [1] ############################

SELECT date(((PERIOD_ADD
  (EXTRACT(YEAR_MONTH 
     FROM CURDATE()),-3)*100)+1));
     
SELECT DATE(DATE_SUB(CURDATE(),
 INTERVAL 3 MONTH)) as lastdate;

     
############################# [2] ##########################

SELECT LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 3 MONTH));

######################## [3] #########################

SELECT DISTINCT DATE_ADD(hire_date, INTERVAL(7 - DAYOFWEEK(hire_date)) DAY) AS monday
FROM employees
WHERE DAYOFWEEK(hire_date) = 2;

SELECT DISTINCT(STR_TO_DATE
     (CONCAT(YEARWEEK(hire_date),'1'),'%x%v%w'))  AS MONDAYS
          FROM employees;
          
SELECT DISTINCT DATE_SUB(hire_date, INTERVAL WEEKDAY(hire_date) DAY) AS monday
FROM employees
WHERE WEEKDAY(hire_date) = 0;

####################### [4] ##########################

SELECT MAKEDATE(EXTRACT(YEAR FROM CURDATE()),1);

SELECT DATE_FORMAT(NOW(), '%Y-01-01') AS first_day_of_year;

########################## [5] ################

SELECT makedate(extract(year from curdate()),12);

SELECT date_format(now(), "%Y-12-31") AS last_day_of_year;

###########################3 [6] #######################

SELECT YEAR(CURRENT_TIMESTAMP) - 
         YEAR("1967-06-08") - 
             (RIGHT(CURRENT_TIMESTAMP, 5) < 
                  RIGHT("1967-06-08", 5)) as age;

SELECT TIMESTAMPDIFF(YEAR, '1967-06-08', CURRENT_DATE()) as age;
 
#################### [7] ########################

SELECT DATE_FORMAT(NOW(), '%M ,%e, %Y') AS 'Current_date';

######################### [8] ###########################

SELECT DATE_FORMAT(NOW(), '%W ,%M, %Y') AS 'Current_date';

#################### [9] ################################

SELECT extract(year from now());
############################### [10] #########################

SELECT from_days(730677);

########################### [11] ############################

SELECT first_name , hire_date
from employees
WHERE hire_Date BETWEEN '1987-06-01' AND '1987-07-30';

############################ [12] #############################

SELECT date_format(now(), '%W %D %M %Y 00:00:00' ) as current_day;

######################### [14] #################################

SELECT date_format(now(), '%r %M %d, %Y' ) as current_day;

########################### [15] #################################

SELECT first_name, last_name , hire_Date
FROM employees
WHERE MONTH(hire_date) = 6;

############################## [16] ###########################

SELECT date_format(hire_date ,'%Y')
FROM employees
GROUP BY date_format(hire_date ,'%Y')
HAVING count(employee_id) > 10;

############################# [18] ##############################

SELECT e.first_name , d.department_name,e.salary,e.hire_date
from departments d join employees e
ON e.manager_id = d.manager_id
where year(hire_date) > 5;


########################### [19] #############################

 SELECT employee_id, last_name, hire_date,  LAST_DAY(hire_date)
  FROM employees;
  
  ######################### [20] ############################
  
SELECT first_name , sysdate(),hire_date , datediff(sysdate(),hire_date)/365
from employees;
  
  ######################## [21]###########################
  
SELECT department_id, year(hire_date),count(*)
FROM employees
GROUP BY department_id, year(hire_date)
ORDER BY department_id;

######  MySQL String - Exercises, Practice, Solution  #######

######################## [1] ##########################3

SELECT job_id, GROUP_CONCAT(employee_id, ' ')  'Employees ID' 
FROM employees GROUP BY job_id;

################ [2] #######################

update employees
set phone_number = REPLACE(phone_number , '124', '999')
WHERE phone_number like '%124%';

select * from employees
WHERE phone_number LIKE '%999%';

###################### [3] ###################333

SELECT first_name , length(first_name)
FROM employees
WHERE length(first_name) >= 8;


#########################3 [4] ###########################

SELECT job_id , lpad(max_salary,7,'0') 'MAX_SALARY',
lpad(min_salary ,7,'*') 'MIN_SALARY'
FROM jobs;

############################# [6] ##############################
SELECT employee_id , first_name ,MID(hire_date,6,2)
from employees;

################### [7] #################

SELECT employee_id , email, reverse(substr(reverse(email), 4)) AS "EMAIL_ID"
FROM employees;

################################ [8] ############################

select upper(first_name)
FROM employees;

######################## [9] ############################

SELECT right(phone_number , 4) as "PH.NO"
FROM employees;

######################### [10] ############################

SELECT 
    location_id, street_address, SUBSTRING_INDEX(street_address, ' ',-1) AS last_word
FROM 
    locations
    ORDER BY
    
    
######################### [11] ################################

select * FROM locations
WHERE length(street_address) <= (SELECT min(length(street_address))
FROM locations);

################################# [12] #############################

SELECT job_title , substr(job_title,1, instr(job_title, ' ')-1)
FROM jobs;

#################################### [13] ##########################

SELECT first_name , last_name FROM employees
WHERE instr(last_name , 'c') >2;

########################## [14] ##################################

SELECT first_name , length(first_name)
FROM employees
WHERE first_name like 'j%'
OR first_name like 'm%'
OR first_name like 'a%'
ORDER BY first_name;

########################## [16] ##############################

select LEFT(first_name , 8 ), concat_ws( "$ ",salary)
from employees
ORDER BY concat( "$ "salary);

SELECT left(first_name, 8),
REPEAT('$', FLOOR(salary/1000)) 
'SALARY($)', salary
FROM employees
ORDER BY salary DESC;

###################################### [15] ##########################333

select first_name , lpad(salary,10,'$') AS SALARY 
from employees;

############################# [17] #####################

SELECT employee_id , first_name, last_name , hire_date
FROM employees
WHERE dayofmonth(hire_date) = 7 OR month(hire_date) = 7;








  
  
  
  
  
  
  
  
  
  
  
  
  




























































































