-- 1. Write a SQL query to select the first_name and last_name of all employees with salary higher than 100,000. How many employees were there?
SELECT * FROM sql_hr.employees;

SELECT first_name, last_name 
FROM sql_hr.employees 
WHERE salary > 100000;

-- 2. Write a SQL query to return employee_id and salary of the top 5 employees based on the salary? What is the 3rd highest salary?
SELECT employee_id, salary 
FROM sql_hr.employees 
ORDER by salary DESC 
LIMIT 5;

-- 3. Write a query to list out all the unique office_id in the employees table. How many different office_id are there?
SELECT Distinct office_id FROM sql_hr.employees;

-- 4. List out all the office_id in Ohio state
SELECT * FROM sql_hr.offices;

SELECT office_id FROM sql_hr.offices WHERE state = 'OH';

-- 5. List out the office_id which are located in either Cincinnati or New York City
SELECT office_id FROM sql_hr.offices WHERE city IN ('Cincinnati', 'New York City');