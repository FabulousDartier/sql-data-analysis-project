/*
===============================================================
Cumulative Analysis
===============================================================
Purpose:
- To track trends, growth, and performance in key business metrics over time.
- For time-series analysis and identifying seasonal patterns.
- To measure growth or decline over specific periods.

SQL Functions Used:
- Date Functions: DATETRUNC(), YEAR(), MONTH()
- Aggregate Functions: SUM(), COUNT(), AVG(), OVER()
===============================================================
*/

-- Calculate the total sales per month
-- and the running total of sales over time
SELECT
    order_date,
    total_sales,
    SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales,
    AVG(avg_price) OVER (ORDER BY order_date) AS moving_average_sales
FROM (
    SELECT 
        DATETRUNC(month, order_date) AS order_date,
        SUM(sales_amount) AS total_sales,
        AVG(price) AS avg_price
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATETRUNC(month, order_date)
) AS t;
