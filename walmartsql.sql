-- create table.
CREATE TABLE walmart(
invoice_ID VARCHAR(15) PRIMARY KEY,
branch VARCHAR(5) ,
city VARCHAR(15),
customer_type VARCHAR(10),
gender VARCHAR(10),
product_line VARCHAR(50),
unit_price FLOAT,
quantity INT,
tax_5percent FLOAT,
total FLOAT,
date DATE ,
time TIME,
payment VARCHAR(15),
cogs FLOAT,
gross_margin_percentage FLOAT,
gross_income FLOAT,
rating FLOAT
);

--- check dataset.
SELECT * FROM walmart;

-- check for total number of rows present

SELECT COUNT(*) FROM walmart;


-- inconsistency check
SELECT * FROM walmart
WHERE
		invoice_id IS NULL
		OR
		branch IS NULL
		OR
		city IS NULL
		OR
		customer_type IS NULL
		OR
		gender IS NULL
		OR
		product_line IS NULL
		OR
		unit_price IS NULL
		OR
		quantity IS NULL
		OR
		tax_5percent IS NULL
		OR
		total  IS NULL
		OR
		date IS NULL
		OR
		time IS NULL
		OR
		payment IS NULL
		OR
		cogs IS NULL
		OR 
		gross_margin_percentage IS NULL
		OR
		gross_income IS NULL
		OR
		rating IS NULL

--- 1.  Retrieve all columns for sales made in a specific branch (e.g., Branch 'A').----------------

SELECT * FROM walmart
WHERE branch = 'A';


--- 2. Find the total sales for each product line.---
SELECT product_line, SUM(total) AS total_sales
FROM walmart
GROUP BY product_line;



--- 3. List all sales transactions where the payment method was 'Cash'.--------

SELECT * FROM walmart
WHERE payment = 'Cash';

--- 4.  Calculate the total gross income generated in each city. -----

SELECT city, SUM(gross_income) AS total_gross_income
FROM walmart
GROUP BY city;


--- 5. Find the average rating given by customers in each branch. --------

SELECT branch, AVG(rating) AS average_rating
FROM walmart
GROUP BY branch;


--- 6. Determine the total quantity of each product line sold.----------

SELECT product_line, SUM(quantity) AS total_quantity_sold
FROM walmart
GROUP BY product_line;


---- 7. List the top 5 products by unit price. ----------

SELECT *
FROM walmart
ORDER BY unit_price DESC
LIMIT 5;


---- 8. Find sales transactions with a gross income greater than 30.-----

SELECT *
FROM walmart
WHERE gross_income > 30;


----- 9.  Retrieve sales transactions that occurred on weekends.-------
SELECT *
FROM walmart
WHERE EXTRACT(DOW FROM date::date) IN (0, 6);


---- 10.  Calculate the total sales and gross income for each month.-------

SELECT 
    DATE_TRUNC('month', date::date) AS month,
    SUM(total) AS total_sales,
    SUM(gross_income) AS total_gross_income
FROM walmart
GROUP BY month
ORDER BY month;


--- 11.  Find the number of sales transactions that occurred after 6 PM.-----

SELECT COUNT(*) AS number_of_transactions_after_6pm
FROM walmart
WHERE "time"::time > '18:00:00';


---- 12.  List the sales transactions that have a higher total than the average total of all transactions. -----

SELECT *
FROM walmart
WHERE total > (SELECT AVG(total) FROM walmart);



---- 13. Calculate the cumulative gross income for each branch by date.------

SELECT 
    branch,
    date::date,
    SUM(gross_income) OVER (PARTITION BY branch ORDER BY date::date) AS cumulative_gross_income
FROM walmart
ORDER BY branch, date::date;



------ 14. Find the total cogs for each customer type in each city.---

SELECT 
    city,
    customer_type,
    SUM(cogs) AS total_cogs
FROM walmart
GROUP BY city, customer_type
ORDER BY city, customer_type;













