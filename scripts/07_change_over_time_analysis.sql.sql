/*
===============================================================
Change Over Time Analysis
===============================================================
Purpose:
- To track trends, growth, and performance in key business metrics over time.
- For time-series analysis and identifying seasonal patterns.
- To measure growth or decline over specific periods.

SQL Functions Used:
- Date Functions: DATETRUNC(), YEAR(), MONTH()
- Aggregate Functions: SUM(), COUNT(), AVG()
===============================================================
*/

-- Change over time sales and customer count by month
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM
    gold.fact_sales
WHERE
    order_date IS NOT NULL
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY
    YEAR(order_date),
    MONTH(order_date);

-- DATETRUNC for monthly aggregation
SELECT
    DATETRUNC(month, order_date) AS order_date,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM
    gold.fact_sales
WHERE
    order_date IS NOT NULL
GROUP BY
    DATETRUNC(month, order_date)
ORDER BY
    DATETRUNC(month, order_date);
