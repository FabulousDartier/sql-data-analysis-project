/*
============================================================
Customer Report
============================================================
Purpose:
    - This report consolidates customer metrics and behaviors

Highlights:
1. Gather essential customer data such as names, ages, and transaction details.
2. Segments customers into categories (VIP, Regular, New) and age groups.
3. Aggregates customer-level metrics:
    - total orders
    - total sales
    - total quantity purchased
    - lifespan (in months)
4. Calculates valuable KPIs:
    - recency (months since last order)
    - average order value
    - average monthly spend
============================================================
*/

CREATE VIEW gold.report_customer_summary AS
WITH base_query AS (
    /*
    ------------------------------------------------------------
    1) Base Query: Retrieves core columns from tables
    ------------------------------------------------------------
    */
    SELECT
        f.order_number,
        f.product_key,
        f.order_date,
        f.sales_amount,
        f.quantity,
        c.customer_key,
        c.customer_number,
        CONCAT(c.first_name, ' ', c.last_name) AS full_name,
        DATEDIFF(year, c.birthday, GETDATE()) AS age
    FROM gold.fact_sales AS f
    LEFT JOIN gold.dim_customers AS c ON c.customer_key = f.customer_key
    WHERE f.order_date IS NOT NULL
),
customer_aggregation AS (
    /*
    ------------------------------------------------------------
    2) Customer Aggregation: Summarizes customer metrics
    ------------------------------------------------------------
    */
    SELECT
        customer_key,
        customer_number,
        full_name,
        age,
        COUNT(DISTINCT order_number) AS total_orders,
        SUM(sales_amount) AS total_sales,
        SUM(quantity) AS total_quantity,
        COUNT(DISTINCT product_key) AS total_products,
        MAX(order_date) AS last_order_date,
        DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan_months
    FROM base_query
    GROUP BY 
        customer_key,
        customer_number,
        full_name,
        age
)
SELECT
    customer_key,
    customer_number,
    full_name,
    age,
    CASE 
        WHEN age < 20 THEN 'Under 20'
        WHEN age BETWEEN 20 AND 29 THEN '20-29'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        ELSE '50 and above' 
    END AS age_group,
    CASE 
        WHEN lifespan_months >= 12 AND total_sales > 5000 THEN 'VIP'
        WHEN lifespan_months >= 12 AND total_sales <= 5000 THEN 'Regular'
        WHEN lifespan_months < 12 THEN 'New'
    END AS customer_segments,
    last_order_date,
    DATEDIFF(month, last_order_date, GETDATE()) AS recency,
    total_orders,
    total_sales,
    total_quantity,
    total_products,
    lifespan_months,
    -- Compute average order value (aov)
    CASE 
        WHEN total_orders > 0 THEN total_sales / total_orders
        ELSE 0
    END AS average_order_value,
    -- Compute average monthly spend
    CASE 
        WHEN lifespan_months > 0 THEN total_sales / lifespan_months
        ELSE 0
    END AS average_monthly_spend
FROM customer_aggregation;
