-- Day 4 – 19th Oct (Monday)

-- 1.List all Credit cards with a credit limit of 200,000 or more, showing card id, account id and credit limit, highest limit first.
SELECT * FROM cards;
SELECT card_id,account_id,credit_limit FROM cards WHERE credit_limit > 200000 ORDER BY credit_limit DESC;

-- 2.Find all Active loans with a principal amount above 2,000,000 and an interest rate below 10%.
SELECT * FROM loans;
SELECT loan_id,principal_amount,interest_rate FROM loans WHERE principal_amount > 2000000 AND interest_rate < 10 AND status = 'Active';

-- 3.List customers born after 1st January 1990 who do not live in Hyderabad, Mumbai or Delhi.
SELECT * FROM customers;
SELECT customer_id,first_name FROM customers WHERE date_of_birth > 1990-01-01 AND city NOT IN ('Hyderabad', 'Mumbai' , 'Delhi');
-- 4.For each combination of transaction type and channel, show the number of transactions and the total amount.
SELECT * FROM transactions;
SELECT txn_type,channel,COUNT(transaction_id) AS number_of_transactions,SUM(amount) AS total_amount FROM transactions GROUP BY txn_type,channel;

-- 5.For loans with a term of 60 months or more, show loan id, principal, interest rate, the principal expressed in lakhs rounded up (CEIL),
-- and an estimated monthly EMI rounded to 2 decimals using: principal × (1 + rate/100 × term/12) ÷ term.
SELECT loan_id,CEIL(principal_amount),interest_rate,ROUND(principal_amount * (1 + interest_rate/100 * term_months/12) / term_months,2) 
AS estimated_monthly_EMI FROM loans WHERE term_months >= 60;

-- 6.Using a correlated subquery, list the employees who earn more than the average salary of their own branch.
SELECT * FROM employees;
SELECT employee_id,first_name,salary,branch_id FROM employees e WHERE salary > (SELECT AVG(salary) FROM employees WHERE branch_id = e.branch_id);

-- 7.Show each account type name with the number of accounts of that type, using a RIGHT JOIN so that account types with zero accounts are also shown.
SELECT * FROM accounts;
SELECT * FROM account_types;
SELECT ac.type_name,COUNT(account_number) FROM accounts a RIGHT JOIN account_types ac ON ac.type_id = a.type_id GROUP BY ac.type_name;

-- 8.Generate every possible combination of branch name and account type name using a CROSS JOIN, and state the total number of rows produced.
SELECT * FROM branches;
SELECT b.branch_name,at.type_name
FROM branches b
CROSS JOIN account_types at;   -- we do not use on condition with CROSS JOIN

-- no.of rows produced 
SELECT(SELECT COUNT(*) FROM branches) * (SELECT COUNT(*) FROM account_types) AS total_combinations; 

-- 9.Using a derived table (a subquery in the FROM clause), find the branches whose total account balance is above the average of all branches’ 
-- total balances

