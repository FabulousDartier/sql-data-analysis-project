/*
===============================================================
Dimensions Exploration
===============================================================
This SQL script is designed to explore the dimensions tables

SQL Functions Used:
- DISTINCT
- ORDER BY
================================================================
*/

-- Explore all countries our customers come from
SELECT DISTINCT country
FROM gold.dim_customers;
ORDER BY country;

-- Explore all categories "The major divisions"
SELECT DISTINCT category, subcategory, product_name
FROM gold.dim_products
ORDER BY category, subcategory, product_name;
