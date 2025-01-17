USE invoicing;

SELECT i.invoice_id, i.invoice_total, p.date, p.amount
FROM invoices as i
LEFT JOIN payments as p
USING(invoice_id)
WHERE i.client_id = 5
;

-- ----------------------------------------------------------
USE store;

-- Question 11
SELECT first_name, last_name, order_date
FROM customers
INNER JOIN orders
USING(customer_id)
;

-- Question 12
SELECT customer_id, city, state, order_date
FROM customers
LEFT JOIN orders
USING(customer_id)
;

-- Question 13
SELECT first_name, last_name, order_date
FROM customers
INNER JOIN orders
USING(customer_id)
WHERE YEAR(order_date) = 2018
;

-- Question 14

SELECT first_name, last_name, name as product_name
FROM customers as c
INNER JOIN orders as o USING(customer_id)
INNER JOIN order_items as oi USING(order_id)
INNER JOIN products as p USING(product_id)
WHERE p.name = "Petit Baguette";

-- Question 15

SELECT COUNT(*) as num_items
from order_items
WHERE product_id = 3;

-- Question 16

SELECT SUM(oi.unit_price*quantity) as Revenue
from order_items oi
INNER JOIN products p
on oi.product_id = p.product_id
WHERE p.name = "Foam Dinner Plate";

-- Question 17

SELECT p.product_id, name, SUM(oi.unit_price*quantity) as Revenue
from order_items oi
INNER JOIN products p
on oi.product_id = p.product_id
GROUP BY product_id, name
HAVING Revenue > 100;

-- SELECT - FROM - JOIN - ON/USING - WHERE - GROUP BY - HAVING - ORDER BY
-- Unique: DISTINCT
