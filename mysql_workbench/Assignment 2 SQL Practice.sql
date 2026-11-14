-- Assignment 2:

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
SELECT * FROM orders;
use sql_playground;
SELECT * FROM employees;
SELECT emp.employee_id,emp.first_name,man.first_name FROM employees emp  JOIN employees man ON emp.manager_id = man.employee_id;


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
-- Display each customer's ID, full name, city, total number of orders, and total order value across all their orders.
-- Show only customers whose total order value exceeds ₹10,000.
-- Sort by total order value in descending order.

-- Q10. Employee-manager hierarchy
-- Display every employee's full name, department, salary, and manager's full name.
-- Include top-level employees who do not have a manager.
-- Sort by manager's name and then employee salary in descending order.