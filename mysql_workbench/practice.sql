-- 1. Retrieve the product name, unit price, and stock quantity of all products whose unit price is greater than ₹2,000. 
-- Display the most expensive products first.
show databases;
use sql_playground;
select * from products;
SELECT product_name,unit_price,stock_quantity FROM products
WHERE unit_price > 2000
ORDER BY unit_price DESC;
-- 2. Find all active customers who belong to either Chennai or Hyderabad. Display their first name, last name, city, and email.
SELECT * FROM customers;
SELECT first_name,last_name,city,email FROM customers
WHERE is_active = 1 AND city IN('chennai','hyderabad');
-- 3. Display the five highest-paid employees, including their first name, last name, department, and salary.
SELECT * FROM employees;
SELECT first_name,last_name,department,salary FROM employees
ORDER BY salary DESC;
-- 4. Calculate the following for all products that are not discontinued:
--  Total number of products
--  Average unit price
--  Minimum unit price
--  Maximum unit price
--  Total stock quantity
SELECT * FROM products;
SELECT COUNT(product_name) as total_products FROM products
WHERE is_discontinued = 0;
SELECT AVG(unit_price) as avg_unit_price FROM products
WHERE is_discontinued = 0;
SELECT MIN(unit_price) as minimum_unit_price FROM products
WHERE is_discontinued = 0;
SELECT MAX(unit_price) as maximun_unit_price FROM products
WHERE is_discontinued = 0;
SELECT SUM(stock_quantity) as total_stock_quantity  FROM products
WHERE is_discontinued = 0;

-- 5. Display each product's name, unit price, and category name. Show only products priced above ₹1,000.
SELECT * FROM products;
SELECT * FROM categories;
SELECT  p.product_name,p.unit_price,c.category_name FROM products p 
LEFT JOIN categories c ON p.category_id = c.category_id
WHERE unit_price > 1000;

-- 6. Display the order ID, order date, customer full name, and order status for all orders placed by customers from Chennai.
SELECT * FROM orders;
SELECT * FROM customers;
SELECT o.order_id,o.order_date,CONCAT(c.first_name,' ',c.last_name) as full_name,o.status FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
WHERE c.city = 'chennai';

-- 7. Display every customer and their order IDs, including customers who have never placed an order.
SELECT * FROM customers;
SELECT * FROM orders;

SELECT c.customer_id,c.first_name,c.last_name,o.order_id FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;


-- 8. Find the number of orders placed by each customer. Display the customer ID, customer full name, and total number of orders. 
-- Include only customers who have placed at least one order. Sort the results by the total number of orders in descending order.
SELECT c.customer_id,CONCAT(c.first_name,' ',c.last_name) as customer_full_name,count(o.order_id) AS total_no_of_orders FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id GROUP BY c.customer_id 
ORDER BY count(o.order_id) DESC;
-- 9. Calculate the total value of the items in each order. Display the order ID and total order value, sorted from highest to lowest.
SELECT order_id,SUM(quantity * unit_price) AS total_order_value FROM order_items
GROUP BY order_id
ORDER BY total_order_value DESC;


-- 10. For each product category, calculate:
--  Category name
--  Number of products
--  Average product price
--  Total stock quantity
-- Display only categories having more than four products, and sort them by average product price from highest to lowest.
SELECT * FROM products;
SELECT * FROM categories;
SELECT p.product_name,c.category_name FROM categories c 
INNER JOIN products p ON c.category_id = p.category_id;
 
SELECT count(p.product_name) AS number_of_products,c.category_name FROM categories c 
INNER JOIN products p ON c.category_id = p.category_id
GROUP BY category_name;

SELECT AVG(p.unit_price) AS average_product_price,c.category_name FROM products p
INNER JOIN categories c ON c.category_id = p.category_id
GROUP BY category_name;

SELECT sum(p.stock_quantity) AS total_stack_quantity,c.category_name FROM products p
INNER JOIN categories c ON c.category_id = p.category_id
GROUP BY category_name;

SELECT COUNT(p.product_name) AS number_of_products, c.category_name FROM products p
INNER JOIN categories c ON c.category_id = p.category_id
GROUP BY category_name
HAVING number_of_products > 4;

