/*
===============================================================
Performance Analysis
===============================================================
Purpose:
- To measure the performance of products, customers, regions over time.
- For benchmarking and identifying trends in sales performance.
- To tracking yearly trends and growth.

SQL Functions Used:
- Functions: LAG()
- Window Functions: AVG() OVER()
===============================================================
*/

/* Analyze the yearly performance of products by comparing their sales
to both the average sales performance of the product and the previous year's sales*/
with yearly_product_sales as (
    select
        year(f.order_date) as order_year,
        p.product_name, 
        sum(f.sales_amount) as current_sales
    from gold.fact_sales as f
    left join gold.dim_products as p 
    on f.product_key = p.product_key
    where f.order_date is not NULL
    group BY
        year(f.order_date),
        p.product_name
)
select 
    order_year,
    product_name,
    current_sales,
    avg(current_sales) over (PARTITION by product_name) as avg_sales,
    current_sales - avg(current_sales) over (partition by product_name) as diff_avg,
    case    
        when current_sales - avg(current_sales) over (partition by product_name) > 0 then 'Above Avg'
        when    current_sales - avg(current_sales) over (partition by product_name) < 0 then 'Below Avg'
        else 'Avg'
    end avg_change,
    lag(current_sales) over(partition by product_name order by order_year) as prev_sales,
    current_sales - lag(current_sales) over(partition by product_name order by order_year) as diff_prev,
    case    
        when current_sales - lag(current_sales) over(partition by product_name order by order_year) > 0 then 'Increase'
        when current_sales - lag(current_sales) over(partition by product_name order by order_year) < 0 then 'Decrease'
        else 'No change'
    end prev_change
from yearly_product_sales
order by product_name, order_year
