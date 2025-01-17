/* JOIN between customer and orders 
Change the JOIN to LEFT OR RIGHT as needed*/

USE store; #Run this by itself

SELECT customers.first_name, 
       customers.last_name, 
       orders.order_date 
FROM 
customers  -- LEFT TABLE
INNER JOIN 
orders     -- RIGHT TABLE
ON
customers.customer_id = 
             orders.customer_id;
             
/*INNER JOIN WITH Aliases. 
  SELECT caluse needed only if same column names appear in multiple tables
*/

SELECT c.first_name, 
       c.last_name, 
       o.order_date 
FROM 
customers AS c 
INNER JOIN 
orders AS o
ON
c.customer_id = 
             o.customer_id;
             
/* customer_id appears in both tables, so alias reference is needed
in the SELECT Clause */

SELECT c.customer_id
	     first_name, 
         last_name, 
         order_date 
FROM 
customers c 
INNER JOIN 
orders o
ON
c.customer_id = 
             o.customer_id;
			
/* JOIN condition with 'USING' keyword*/           
SELECT c.customer_id,
	     first_name, 
         last_name, 
         order_date 
FROM 
customers c 
INNER JOIN 
orders o
USING(customer_id);

/* LEFT OR RIGHT Join, change the KEY WORD*/
SELECT   first_name, 
         last_name, 
         order_date 
FROM 
customers c 
LEFT JOIN 
orders o
USING(customer_id);

/* Demo of ONE Row in the left table splitting into 5 rows when matched with the right table*/
USE invoicing; #Run this by itself

/* One row in clients for client_id = 1*/
SELECT client_id, name, state
FROM 
clients 
WHERE client_id = 1; 

/* 5 rows for client_id = 1 in invoices
Therefore the JOIN will return 5 row */

Select client_id, name, state, invoice_date
from clients 
LEFT JOIN 
invoices 
USING(client_id)
WHERE client_id = 1;

/* Join conditions with more than 2 tables 
Query joining user, watch and item to get the names and stream time of all users
who watched 'American Hustle*/

USE streaming; #Run this by itself

SELECT first_name, 
       last_name,
       stream_time 
FROM 
   user
INNER JOIN 
   watch 
USING(user_id) 
INNER JOIN
   item
USING(item_id)
WHERE 
item_name = 'American Hustle';

/*Exercises*/
USE invoicing;

SELECT i.invoice_id,
	   i.invoice_total,
       p.date AS payment_dt,
       p.amount
FROM 
	invoices as i
LEFT JOIN
	payments as p
USING(invoice_id)
WHERE i.client_id = 5;

/*Exercises*/
USE store;

SELECT first_name, last_name, city, order_id, order_date, product_id, quantity
FROM customers as c
INNER JOIN orders as o USING(customer_id)
INNER JOIN order_items as oi USING(order_id)
WHERE state = "GA";




















USE streaming;

SELECT i.Item_Name, SUM(w.Stream_Time) AS total_stream_time
FROM watch w
INNER JOIN user u ON w.User_ID = u.User_ID
INNER JOIN item i ON w.Item_ID = i.Item_ID
WHERE u.Gender = 'female' AND i.Category = 'Movie'
GROUP BY i.Item_Name
HAVING total_stream_time > 5000;



USE store;

SELECT p.name, SUM(i.quantity*i.unit_price) AS revenue
FROM order_items i
INNER JOIN products p ON i.product_id = p.product_id
INNER JOIN orders o on i.order_id = o.order_id
WHERE YEAR(o.order_date) = "2018"
GROUP BY p.name
HAVING revenue > 20
;


SELECT p.name, 
		YEAR(o.order_date) AS year, 
		SUM(i.quantity * i.unit_price) AS revenue
FROM order_items i
INNER JOIN products p ON i.product_id = p.product_id
INNER JOIN orders o ON i.order_id = o.order_id
GROUP BY p.name, YEAR(o.order_date)
ORDER BY revenue DESC
LIMIT 3;

