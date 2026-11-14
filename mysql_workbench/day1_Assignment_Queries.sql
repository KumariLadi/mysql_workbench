-- Day 1 – 16th Oct (Friday)
USE banking_database;
-- 1.Display all records from the branches table.
SELECT * FROM branches;
-- 2.Show the first name, last name and city of every customer.
SELECT * FROM customers;
SELECT first_name,last_name,city FROM customers;

-- 3.List the distinct cities in which customers live.
SELECT DISTINCT city FROM customers;

-- 4.Find customers whose first name starts with the letter ‘A’ and who live in either Hyderabad or Mumbai.
SELECT first_name, city FROM customers WHERE first_name LIKE 'A%' AND city IN ('Hyderabad','Mumbai');

-- 5.For Active accounts, display the total, average (rounded to 2 decimals), minimum and maximum balance.
SELECT * FROM accounts;
SELECT SUM(balance) AS total_bal,ROUND(AVG(balance),2) as avg_bal,MIN(balance) AS min_bal,MAX(balance) AS max_bal FROM accounts WHERE status = 'Active';

-- 6.Show the number of customers in each state, but only for states having more than 5 customers. List the state with the most customers first.
SELECT COUNT(customer_id) as count , state FROM customers GROUP BY state HAVING count > 5 ORDER BY count DESC;
-- 7.Display account number, customer full name and account type name for every account (join three tables).
SELECT * FROM account_types;
SELECT a.account_number, CONCAT(c.first_name,' ',c.last_name) AS customer_full_name,ac.type_name FROM customers c INNER JOIN accounts a
ON c.customer_id = a.customer_id INNER JOIN account_types ac ON a.type_id = ac.type_id ORDER BY account_number ;

-- 8.Find the customers who do not have any account.
SELECT * FROM customers;
SELECT * FROM accounts;
SELECT * FROM customers c LEFT JOIN accounts a ON c.customer_id = a.customer_id
WHERE a.customer_id is Null;
-- 8.without using joins
SELECT customer_id,first_name FROM customers WHERE customer_id NOT IN (
    SELECT customer_id FROM accounts);

-- 9.Find the accounts whose balance is higher than the average balance of all accounts. Show account number and balance.
SELECT account_number,balance FROM  accounts WHERE balance > (SELECT AVG(balance) FROM accounts);

-- 10.(DML) Insert a new branch (branch_id 13) of your choice. Then insert a new employee (employee_id 49) working in that branch 
-- as a ‘Branch Manager’ reporting to employee 1. Finally, increase that employee’s salary by 5,000 and verify all three changes with 
-- SELECT statements.
SELECT * FROM branches;
INSERT INTO branches (branch_id,branch_name,city,state,opened_date) VALUES (13,'Vishakapatnam','Vishakapatnam','AndhraPradesh',CURRENT_DATE());
SELECT * FROM employees;
INSERT INTO employees (employee_id,first_name,last_name,branch_id,job_title,salary,hire_date,manager_id) VALUES (49,'Arjun','Reddy',1,'Branch Manager',68000,CURRENT_DATE(),1);
UPDATE employees SET salary = salary + 5000 WHERE employee_id = 49; 