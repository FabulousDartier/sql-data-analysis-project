/*
==========================================================================
Product Report
==========================================================================
Purpose:
    - This report consolidates product metrics and behaviors
Highlights:
1. Gathers essential product data such as names, categories, subcategories, and cost
2. Segments products by revenue to identify High-Performance, Mid-Range, and Low-Performance categories
3. Aggregates product-level metrics:
    - total orders
    - total sales
    - total quantity sold
    - total customers (unique)
    - lifespan (in months)
4. Calculates valuable KPIs:
    - recency (months since last sale)
    - average order revenue
    - average monthly revenue
==========================================================================
*/
CREATE VIEW gold.report_product_summary AS
WITH base_query AS (
    /*
    ------------------------------------------------------------
    1) Base Query: Retrieves core columns from tables
    ------------------------------------------------------------
    */
    SELECT 
        f.order_number,
        f.order_date,
        f.customer_key,
        f.sales_amount,
        f.quantity,
        p.product_key,
        p.product_name,
        p.category,
        p.subcategory,
        p.cost
    FROM gold.fact_sales AS f
    LEFT JOIN gold.dim_products AS p 
        ON p.product_key = f.product_key
    WHERE f.order_date IS NOT NULL
),
product_aggregations AS (
    /*
    ------------------------------------------------------------
    2) Product Aggregation: Summarizes product metrics
    ------------------------------------------------------------
    */
    SELECT 
        product_key,
        product_name,
        category,
        subcategory,
        cost, 
        DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan_months,
        MAX(order_date) AS last_sale_date,
        COUNT(DISTINCT order_number) AS total_orders,
        COUNT(DISTINCT customer_key) AS total_customers,
        SUM(sales_amount) AS total_sales,
        SUM(quantity) AS total_quantity,
        ROUND(AVG(CAST(sales_amount AS FLOAT) / NULLIF(quantity, 0)), 1) AS avg_selling_price
    FROM base_query
    GROUP BY
        product_key,
        product_name,
        category,
        subcategory,
        cost
)
/*
============================================================
3) Final Query: Combines all product results into one output
============================================================
*/
SELECT
    product_key,
    product_name,
    category,
    subcategory,
    cost, 
    last_sale_date,
    DATEDIFF(MONTH, last_sale_date, GETDATE()) AS recency_months,
    CASE 
        WHEN total_sales > 50000 THEN 'High-Performance'
        WHEN total_sales >= 10000 THEN 'Mid-Range'
        ELSE 'Low-Performance'
    END AS product_segments,
    lifespan_months,
    total_orders,
    total_sales,
    total_quantity,
    total_customers,
    avg_selling_price,
    -- Average Order Revenue
    CASE 
        WHEN total_orders = 0 THEN 0
        ELSE total_sales / total_orders
    END AS avg_order_revenue,
    -- Average Monthly Revenue
    CASE
        WHEN lifespan_months = 0 THEN 0
        ELSE total_sales / lifespan_months
    END AS avg_monthly_revenue
FROM product_aggregations;
