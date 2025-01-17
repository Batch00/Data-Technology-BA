/* SQL numeric function */
SELECT ROUND(5.56, 1);

SELECT TRUNCATE(5.6566, 0);

SELECT FLOOR(5.234);

SELECT CEIL(5.234);

SELECT ABS(-3.4);

# Use ROUND function in the previous query 

SELECT name, state, ROUND(stars, 1) as stars, ROUND(avg_stars, 1)  as state_avg 
FROM 
   business b
INNER JOIN
   avg_rating_by_state av 
USING (state) 
WHERE stars > avg_stars;

/* String functions */

/*character length*/
SELECT CHAR_LENGTH("How are you");

/*concatenate*/
SELECT CONCAT('John', ' ', 'Doe');

USE store;
SELECT CONCAT(first_name, ' ', last_name) as full_name FROM customers;

SELECT LEFT(first_name, 3) as full_name FROM customers;
SELECT RIGHT(first_name, 3) as full_name FROM customers;

/*SUBSTR(string, start_position, length)*/

SELECT first_name, SUBSTR(first_name, 2, 2 ) as full_name FROM customers;

#Date functions
SELECT NOW();

SELECT CURRENT_DATE();

SELECT DATE(NOW());

SELECT YEAR(NOW());

SELECT MONTH(NOW());

SELECT DAY(NOW());

SELECT DATE_FORMAT(NOW(), '%Y-%m-%d');

SELECT DATE_FORMAT(NOW(), '%H:%i:%s');

SELECT DATE_FORMAT(NOW(), '%H');

SELECT HOUR(NOW());

SELECT DATE_ADD(NOW(), INTERVAL 1 DAY);

SELECT DATEDIFF('2023-10-31', '2024-10-31');

#Handling Null Values

SELECT order_date, shipped_date from orders;

# IS NULL and IS NOT NULL 
SELECT order_date, shipped_date FROM orders WHERE shipped_date is not null;

# REPLACING NULLS

SELECT order_date, IFNULL(shipped_date, "UNKNOWN") as shipped FROM orders;

SELECT order_date, shipped_date, comments FROM orders;

/*use COALESCE to replace NULLs with a default value, multiple columns.*/
SELECT order_date, shipped_date, comments, COALESCE(shipped_date, comments, "Unknown") as status from orders;

SELECT order_date, COALESCE(shipped_date, comments, "Unknown") as status from orders;



