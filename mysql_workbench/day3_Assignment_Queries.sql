-- Day 3 – 18th Oct (Sunday)

-- 1.Show the first name, job title, monthly salary and annual salary (alias it annual_salary) of all Loan Officers 
-- and Relationship Managers earning more than 50,000 per month.
SELECT * FROM employees;
SELECT first_name,job_title,salary AS monthly_salary,salary*12 AS annual_salary FROM employees WHERE 
job_title IN ('Loan Officer','Relationship Manager') AND salary > 50000;

-- 2.Show the account number, open date and status of accounts opened during the year 2023 whose status is not ‘Active’.
-- Sort by open date (latest first) and display only the first 5 rows.
SELECT * FROM accounts;
SELECT account_number,open_date,status FROM accounts WHERE YEAR(open_date) = 2023 AND status != 'active'
ORDER BY open_date DESC LIMIT 5; 

-- 3.Find the total number of customers and the number of customers who have an email address. Explain in one line why the two numbers differ.
SELECT * FROM customers;
SELECT COUNT(customer_id) AS total_no_of_customers,COUNT(email) AS customers_with_email FROM customers;

-- 4.Calculate each customer’s current age in years using their date of birth, and list customers who are above 60 years old.


-- 5.Show the number of transactions and the total transaction amount for each month of the year 2024.
SELECT * FROM transactions;
SELECT MONTH(txn_date) AS month_no,COUNT(transaction_id) AS no_of_transactions,SUM(amount) AS total_transaction_amount FROM transactions 
WHERE YEAR(txn_date) = 2024 GROUP BY month_no ;

-- 6.Display customer id, full name, email and phone, replacing missing emails with ‘No Email’ and missing phone numbers with ‘Not Provided’. 
-- Show only customers who are missing at least one of the two.

-- 7.List customers who have taken a loan, showing customer name, loan type name, principal amount and loan status.
SELECT * FROM customers;
SELECT * FROM loans;
SELECT * FROM loan_types;
SELECT CONCAT(c.first_name,' ',last_name) AS customer_name,lt.loan_type_name,l.principal_amount,l.status FROM customers c INNER JOIN loans l 
ON c.customer_id = l.customer_id INNER JOIN loan_types lt ON l.loan_type_id = lt.loan_type_id;

-- 8.Produce a single combined list of all cities that appear in either the customers table or the branches table, without duplicates. 
-- Then explain how the result would change if you used UNION ALL.
SELECT * FROM customers;
SELECT DISTINCT(city) FROM customers;
SELECT DISTINCT(city) FROM branches;
SELECT city FROM customers UNION SELECT city FROM branches;
SELECT city FROM customers UNION ALL SELECT city FROM branches;

-- 9.Find the accounts that have never had a transaction using NOT EXISTS.
SELECT * FROM accounts;
SELECT * FROM transactions;
SELECT a.account_id FROM accounts a
WHERE NOT EXISTS (
    SELECT 1
    FROM transactions t WHERE t.account_id = a.account_id); 

-- (DDL) (a) Add a column kyc_status VARCHAR(10) DEFAULT 'Pending' to the customers table.
ALTER TABLE customers ADD COLUMN kyc_status VARCHAR(10) DEFAULT 'pending'; 
-- (b) Update kyc_status to ‘Verified’ for all customers who have at least one Active account. 
UPDATE customers c SET c.kyc_status = 'Verified'
WHERE EXISTS (
    SELECT *
    FROM accounts a WHERE a.customer_id = c.customer_id AND a.status = 'Active');

-- (c) Create a new table high_value_customers from a query that returns customers whose total balance across all accounts exceeds 500,000.

CREATE TABLE high_value_customers AS
SELECT c.customer_id ,SUM(a.balance) AS total_balance FROM customers c
INNER JOIN accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id
HAVING SUM(a.balance) > 500000;
SELECT * FROM high_value_customers;
