/*
===============================================================
Data Segmentation
===============================================================
Purpose:
- To group data into meaningful categories for analysis.
- For customer segmentation, product categorization, and regional analysis.

SQL Functions Used:
- CASE: define custom segmentation logic.
- GROUP BY: aggregate data into segments.
===============================================================
*/

-- Date Segmentation
/* Segment products into cost ranges 
    and count how many products fall into each segment */
WITH product_segments AS (
     SELECT
          product_key,
          product_name,
          cost,
          CASE 
                WHEN cost < 100 THEN 'Below'
                WHEN cost BETWEEN 100 AND 500 THEN '100-500'
                WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
                ELSE 'Above 1000'
          END AS cost_range
     FROM gold.dim_products
)

SELECT 
     cost_range,
     COUNT(product_key) AS total_products
FROM product_segments
GROUP BY cost_range
ORDER BY total_products DESC;

/*
Group customers into 3 segments based on their spending behavior:
    - VIP: Customers with at least 12 months of history and spending more than $5000
    - Regular: Customers with at least 12 months of history and spending 5000 or less
    - New: Customers with a lifespan less than 12 months
And find the total number of customers by each group
*/

WITH customer_category_sales AS (
    SELECT
        c.customer_key,
        SUM(f.sales_amount) AS total_spending,
        MIN(order_date) AS first_order,
        MAX(order_date) AS last_order,
        DATEDIFF(month, MIN(order_date), MAX(order_date)) AS month_diff,
        CASE 
            WHEN (DATEDIFF(month, MIN(order_date), MAX(order_date)) >= 12) AND SUM(f.sales_amount) > 5000 THEN 'VIP'
            WHEN (DATEDIFF(month, MIN(order_date), MAX(order_date)) >= 12) AND SUM(f.sales_amount) <= 5000 THEN 'Regular'
            WHEN (DATEDIFF(month, MIN(order_date), MAX(order_date)) < 12) THEN 'New'
        END AS customer_category
    FROM gold.fact_sales AS f 
    LEFT JOIN gold.dim_customers AS c 
        ON c.customer_key = f.customer_key
    GROUP BY c.customer_key
)

SELECT 
    customer_category,
    COUNT(customer_key) AS number_of_customers
FROM customer_category_sales
GROUP BY customer_category
ORDER BY number_of_customers DESC;
