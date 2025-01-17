# ***************************COUNT FUNCTION ************************************ #
#COUNT()

/* get the number of orders in orders table */
USE store;

SELECT COUNT(*) as num_items FROM orders;

/* get the count of order_items that were ordered from order_items*/

SELECT COUNT(*) from order_items;


/* get the count of unique products that were ordered from order_items*/

SELECT COUNT(DISTINCT product_id) as product_count from order_items;


#****************************SUM FUNCTION***************************************#

#SUM()

-- total quantities sold across all products and orders

SELECT SUM(quantity) FROM order_items;

-- grand total of streaming duration across all shows and movies:
USE streaming;

SELECT SUM(total_duration) as grand_total_duration FROM item;


#**************************** GROUP BY ***************************************#

-- Aggregation by specific rows: quantity sold for product_id = 1

USE store;

SELECT quantity 
FROM order_items 
WHERE
product_id = 1; 

-- total the above quantities:
SELECT SUM(quantity) as tot_qty
FROM order_items 
WHERE 
product_id = 1;

-- use GROUP BY to aggregate by product_id
SELECT product_id, 
       SUM(quantity) as tot_qty
FROM order_items 
-- WHERE product_id in (1,2)
GROUP BY 
product_id;

/* GROUP BY with multiple columns*/

SELECT  SUM(quantity) as tot_qty
FROM order_items 
WHERE order_id = 6 AND product_id = 3 ;


SELECT  order_id, product_id, SUM(quantity) as tot_qty
FROM order_items 
WHERE order_id > 5
GROUP BY order_id, product_id;

/* Aggregation with JOINs */

SELECT p.name as product_name
, SUM(oi.quantity) as tot_quantity
FROM 
products p
INNER JOIN 
order_items oi
USING(product_id)
GROUP BY p.name
HAVING tot_quantity > 5
ORDER BY tot_quantity DESC;

/* Aggregating calculations across multiple columns */

SELECT order_id, product_id, quantity, unit_price, quantity*unit_price
FROM 
order_items;

-- revenue = quantity*unit_price. Aggregate the revenue by order_id with SUM
SELECT order_id, 
       SUM(quantity*unit_price) AS revenue
FROM 
order_items 
GROUP BY 
order_id;

#*************************UNION************************#
USE streaming;
-- first table
SELECT first_name, class_year, last_name 
FROM streaming.user
WHERE class_year = 2017
AND first_name like 'a%n';

-- second table
SELECT first_name, last_name, class_year 
FROM streaming.user
WHERE class_year = 2017
AND first_name like 'b%n';

-- UNION
SELECT first_name, last_name, class_year 
FROM streaming.user
WHERE class_year = 2017
AND first_name like 'a%n'
UNION
SELECT first_name, last_name, class_year 
FROM streaming.user
WHERE class_year = 2017
AND first_name like 'b%n';


-- Exercise 1
USE store;
SELECT p.name as product_name,
	   COUNT(DISTINCT o.order_id) as order_count,
       SUM(oi.quantity*oi.unit_price) as revenue
FROM orders as o
INNER JOIN order_items as oi
USING(order_id)
INNER JOIN products as p
USING(product_id)
WHERE YEAR(o.order_date) IN (2017, 2018)
GROUP BY p.name;

-- Exercise 2

SELECT p.name as product_name,
       SUM(oi.unit_price*quantity) as Revenue
FROM order_items as oi
INNER JOIN products as p
ON oi.product_id = p.product_id
GROUP BY p.name
HAVING Revenue > 100;

 




