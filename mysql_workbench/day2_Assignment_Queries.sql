-- Day 2 – 17th Oct (Saturday)

-- 1.Show the account number and balance of the top 10 accounts with the highest balance.
SELECT * FROM accounts;
SELECT account_number,balance FROM accounts ORDER BY balance DESC LIMIT 10;
-- 2.List all Withdrawal transactions with an amount between 50,000 and 100,000.
SELECT * FROM transactions;
SELECT * FROM transactions WHERE txn_type = 'Withdrawal' AND amount BETWEEN 50000 AND 100000;
-- 3.Find the customers who do not have an email address on record.
SELECT * FROM customers;
SELECT customer_id,first_name FROM customers WHERE email IS null;

-- 4.Display each customer’s full name, their city in uppercase, and the domain of their email address. Exclude customers with no email.
SELECT CONCAT(first_name,' ',last_name) AS customer_full_name,UPPER(city),SUBSTRING_INDEX(email, '@', -1) AS domain FROM customers;

-- 5.Find the job titles whose average monthly salary is greater than 45,000. Show the average rounded to the nearest whole number.
SELECT * FROM employees;
SELECT job_title,ROUND(AVG(salary),2) as avg_salary FROM employees GROUP BY job_title HAVING avg_salary > 45000;

-- 6.Show every branch with the number of employees working there, sorted from highest to lowest.
SELECT * FROM branches;
SELECT count(e.employee_id) AS total_employees,b.branch_name FROM employees e INNER JOIN branches b ON e.branch_id = b.branch_id 
GROUP BY b.branch_id,b.branch_name ORDER BY total_employees DESC;

-- 7.Display each employee’s full name next to their manager’s full name. Employees without a manager should still appear.(self join)
SELECT empCONCAT(emp.first_name,' ',emp.last_name) AS emp_full_name,CONCAT(man.first_name,' ',man.last_name) AS man_full_name FROM employees emp 
LEFT JOIN employees man ON emp.manager_id = man.employee_id;  

-- 8.(a) Using an IN subquery, list the customers (id and full name) who have at least one loan with the status ‘Defaulted’.
SELECT * FROM loans;
SELECT customer_id,CONCAT(first_name,' ',last_name) AS customer_full_name FROM customers WHERE customer_id IN 
(SELECT customer_id FROM loans WHERE status = 'Defaulted');
-- (b) Using EXISTS, list the customers who have at least one Blocked card.
SELECT * FROM cards;
SELECT * FROM accounts;
SELECT * FROM customers;
SELECT account_id FROM accounts a WHERE EXISTS (SELECT 1 FROM cards c  WHERE c.account_id = a.account_id AND status ='Blocked');


-- 9.(DML) (a) Give a 10% salary increase to all Tellers working in branches located in Hyderabad.
SELECT * FROM employees;
SELECT * FROM branches;
SELECT e.employee_id,e.first_name,e.salary ,e.salary*1.1 AS increased_sal FROM employees e INNER JOIN branches b ON e.branch_id = b.branch_id
WHERE b.city = 'Hyderabad' AND  e.job_title = 'Teller';
 -- (b) Delete all cards whose status is ‘Expired’. Verify each change with a SELECT.
 DELETE FROM cards WHERE status = 'Expired';
 