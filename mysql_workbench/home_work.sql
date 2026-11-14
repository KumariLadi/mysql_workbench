-- Home Work Queries
-- 1. Our Products table contains unit prices, Depending on the unit price, categorize the price : 
-- Price less than 500, Consider it as Budget Friendly
-- Price less than 2000, Consider it as Mid Range
-- Price less than 5000, Consider it as Premium
SELECT * FROM products;
SELECT product_id,product_name,unit_price,
CASE
WHEN unit_price < 500 THEN 'Budget Friendly'
WHEN unit_price < 2000 THEN 'Mid Range'
WHEN unit_price < 5000 THEN 'Premium'
ELSE 'Expensive'
END AS price_category FROM products;
-- 2.For each Employee, What are the top 3 approved loan principal. Return the Employee ID, 
-- Employee Full Name, Loan_Id, Principal, and Loan Started date and term end date 
-- along with loan status.
SELECT * FROM employees;
SELECT * FROM loans;
SELECT e.employee_id,CONCAT(first_name,' ',last_name)  AS employee_full_name,l.loan_id,l.principal_amount,DATE_ADD(start_date, INTERVAL term_months MONTH) AS term_end_date,l.status;

-- 3.What is the Mean of the Principal_amount in Loans Table
-- 4.What is the Median of the interest_rate in Loans Table.
-- 5.What is the Mode of the Term Months in Loans Table
-- 6.For each Employee, What are the top 3 approved loan principal. Return the Employee ID, 
-- 7.Employee Full Name, Loan_Id, Principal, and Loan Started date and term end date 
-- along with loan status.
-- 1. Retrieve the product name, unit price, and stock quantity of all products whose unit price is greater than ₹2,000. Display the most expensive products first.
-- 2. Find all active customers who belong to either Chennai or Hyderabad. Display their first name, last name, city, and email.
-- 3. Display the five highest-paid employees, including their first name, last name, department, and salary.
-- 4. Calculate the following for all products that are not discontinued:
-- Total number of products
-- Average unit price
-- Minimum unit price
-- Maximum unit price
-- Total stock quantity
-- 5. Display each product's name, unit price, and category name. Show only products priced above ₹1,000.
-- 6. Display the order ID, order date, customer full name, and order status for all orders placed by customers from Chennai.
-- 7. Display every customer and their order IDs, including customers who have never placed an order.
-- 8. Find the number of orders placed by each customer. Display the customer ID, customer full name, and total number of orders. Include only customers who have placed at least one order. Sort the results by the total number of orders in descending order.
-- 9. Calculate the total value of the items in each order. Display the order ID and total order value, sorted from highest to lowest.

-- 10. For each product category, calculate:
-- Category name
-- Number of products
-- Average product price
-- Total stock quantity
-- Display only categories having more than four products, and sort them by average product price from highest to lowest.


-- Q1. Category-wise sales performance
-- Using categories, products, and order_items, display each category's name, total distinct products sold, total quantity sold, and total sales revenue.
-- Include only categories where the total quantity sold is greater than 10.
-- Sort by total sales revenue in descending order.

-- Q2. Customer order analysis
-- Display every customer's ID, full name, city, and total number of orders, including customers who have never placed an order.
-- Display customers with the highest number of orders first.
-- Show customers with zero orders as well.

-- Q3. Order status by customer city
-- Display each customer's city and the number of orders in each order status, such as pending, paid, shipped, delivered, and cancelled.
-- Show only city-and-status combinations having at least 3 orders.
-- Sort by city and then by order count in descending order.

-- Q4. Calculate the value of every order
-- Display the order ID, order date, customer full name, sales employee's full name, order status, and total order value.
-- Calculate the order value using SUM(quantity * unit_price).
-- Include orders that do not have an assigned employee.
-- Sort by total order value in descending order.

-- Q5. Payment method analysis
-- Using the payments table, display each payment method and payment status along with the number of payments and total payment amount.
-- Group the results by both payment method and payment status.
-- Sort by total payment amount in descending order.

-- Q6. Products that have never been ordered
-- Display the product ID, product name, category name, and unit price of products that have never appeared in order_items.

-- Q7. Category-wise customer review analysis
-- Display every category's name, number of distinct products, number of reviews, and average review rating.
-- Include categories even if their products have no reviews.
-- Sort by average review rating from highest to lowest, placing categories with no reviews last.

-- Q8. Employee sales performance
-- Display every employee's ID, full name, department, number of orders handled, and total sales value.
-- Include employees who have not handled any orders.
-- Calculate sales value from the quantities and unit prices in order_items.
-- Show employees with the highest sales first.

-- Q9. High-value customers
-- Display each customer's ID, full name, city, total number of orders, and total order value across all the
SELECT c.customer_id,CONCAT(c.first_name,' ',c.last_name) AS customer_name,COUNT(o.order_id) AS total_orders,SUM(oi.quantity * oi.unit_price) AS total_order_value
FROM customers c INNER JOIN orders o ON c.customer_id = o.customer_id INNER JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id,c.first_name;

-- Views — Exercises

-- 2. Create a view showing products with price greater than 2,000.
SELECT * FROM products;
CREATE VIEW product_price_above_2000 AS
SELECT product_id,product_name,unit_price FROM products WHERE unit_price > 2000;

-- 3. Create a view showing order ID, customer name, order date, and order status.
SELECT * FROM customers;
CREATE VIEW customer_order_summary AS
SELECT o.order_id,CONCAT(c.first_name,' ',c.last_name) AS customer_name,o.order_date,o.status FROM orders o INNER JOIN customers c
ON o.customer_id = c.customer_id; 

-- 4. Create a view showing each product's total quantity sold.
SELECT * FROM order_items;
SELECT * FROM orders;
CREATE VIEW products_sale_summary AS
SELECT p.product_id,p.product_name,SUM(oi.quantity) AS total_quantity_sold FROM products p INNER JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id,p.product_name;

-- 5. Create a view showing employee details and their department.
SELECT * FROM employees;  -- in sql_playground
CREATE VIEW employee_details AS
SELECT employee_id,CONCAT(first_name,' ',last_name) AS employee_name,email,department FROM employees;

-- 6. Create a view showing only paid payments.
SELECT * FROM payments;
CREATE VIEW successful_payments AS
SELECT * FROM payments WHERE payment_status = 'paid';

-- 7. Create a view showing customer name, total orders, and total order value.
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM order_items;
CREATE VIEW customer_purchase_summary AS
SELECT CONCAT(c.first_name,' ',c.last_name) AS customer_name,COUNT(o.order_id) AS total_orders,SUM(oi.quantity * oi.unit_price) AS total_order_value
FROM customers c INNER JOIN orders o ON c.customer_id = o.customer_id INNER JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id,c.first_name;
-- 8. Modify an existing view using CREATE OR REPLACE VIEW.
CREATE OR REPLACE VIEW product_price_above_2000 AS
SELECT product_id,product_name,unit_price FROM products WHERE unit_price > 2000;
SELECT * FROM product_price_above_2000;

-- 9. Test updating a simple view.
CREATE VIEW customer_details AS
SELECT customer_id,CONCAT(first_name,' ',last_name) AS customer_name,city FROM customers;

UPDATE customer_details
SET city = 'Delhi'
WHERE customer_id = 1;

SELECT * FROM customer_details; -- updated in both the tables
SELECT * FROM customers;
