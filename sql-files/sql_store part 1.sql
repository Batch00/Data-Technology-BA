-- 6. List out all the customers who were born between 1980 and 1990 in ascending order of their age
SELECT * FROM store.customers;

SELECT customer_id, first_name, last_name 
FROM store.customers 
WHERE birth_date BETWEEN '1980-01-01' AND '1990-12-31'
ORDER BY birth_date ASC;

-- 7. List out all the order_id and product_id from order_items table that sold at least 5 units
SELECT * FROM store.order_items;

SELECT order_id, product_id FROM store.order_items WHERE quantity >= 5;

-- 8. List out all the names of the products from product table that had unit_price of 3.29
SELECT * FROM store.products;

SELECT name FROM store.products WHERE unit_price = 3.29;

-- 9. List out the first name and last name of customers from customers table, whoreside in one of these cities – Chicago, Atlanta, Orlando, Arlington
SELECT * FROM store.customers;

SELECT first_name, last_name 
FROM store.customers 
WHERE city in ('Chicago', 'Atlanta', 'Orlando', 'Arlington');

-- 10.List out all the customers whose first name starts with ‘I’
SELECT * FROM store.customers;

SELECT customer_id, first_name, last_name 
FROM store.customers 
WHERE first_name LIKE 'I%';


