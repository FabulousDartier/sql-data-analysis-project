/*
===============================================================
Date Range Exploration
===============================================================
Purpose:
- To determine the date range of the dataset.
- To understand the time span of the data.

SQL Functions Used:
- MIN(), MAX(), DATEDIFF()
================================================================
*/

-- Find the date of the first and last order
-- How many years of sales are available
SELECT
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date,
    DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS order_range_months
FROM gold.fact_sales;

-- Find the youngest and the oldest customer
SELECT
    MIN(birthday) AS oldest_birthday,
    DATEDIFF(YEAR, MIN(birthday), GETDATE()) AS oldest_age,
    MAX(birthday) AS youngest_birthday,
    DATEDIFF(YEAR, MAX(birthday), GETDATE()) AS youngest_age
FROM gold.dim_customers;
