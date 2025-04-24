/*
===============================================================================
Database Exploration
===============================================================================
Purpose:
    - To explore the structure of the database, including the list of tables and their schemas.
    - To inspect the columns and metadata for specific tables.

Table Used:
    - INFORMATION_SCHEMA.TABLES
    - INFORMATION_SCHEMA.COLUMNS
===============================================================================
*/


-- Retrieving all the Objects in the Database
select *
from INFORMATION_SCHEMA.TABLES;


-- Retrieving all the columns in the Databse
select *
from INFORMATION_SCHEMA.columns


-- Retrieving all the columns with respect to the specific tables
select COLUMN_NAME, DATA_TYPE, IS_NULLABLE, CHARACTER_MAXIMUM_LENGTH
from INFORMATION_SCHEMA.columns
where TABLE_NAME = 'dim_customers'