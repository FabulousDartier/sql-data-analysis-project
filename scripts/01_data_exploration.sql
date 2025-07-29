/* 
====================================================================
Database Exploation
====================================================================
Purpose: 
This script is designed to explore the database by querying tables and schemas.
To inspect columns and metadata for specific tables.

Tables Used:
- INFORMATION_SCHEMA.COLUMNS
- INFORMATION_SCHEMA.TABLES
=====================================================================
*/

-- Retrive a list of all tables in the database
SELECT 
    TABLE_CATALOG, 
    TABLE_SCHEMA, 
    TABLE_NAME, 
    TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES;

-- Retrieve all columns for a specific table (dim_customers)
SELECT 
    COLUMN_NAME, 
    DATA_TYPE, 
    IS_NULLABLE, 
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers';
