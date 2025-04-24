/*
===============================================================================
Date Range Exploration 
===============================================================================
Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.

SQL Functions Used:
    - MIN(), MAX(), DATEDIFF()
===============================================================================
*/


-- Exploring the first and last order in the dataset and the year of sales
-- Order Range (Years)
select
min(order_date) as first_order_date,
max(order_date) as last_order_date,
datediff(year, min(order_date), max(order_date)) as order_range_years
from gold.fact_sales;


-- Order Range (Months)
select
min(order_date) as first_order_date,
max(order_date) as last_order_date,
datediff(month, min(order_date), max(order_date)) as order_range_months
from gold.fact_sales;


-- Youngest and the Oldest Customers with the Birth Date
select
min(birthdate) as oldest_customer,
max(birthdate) as youngest_customer
from gold.dim_customers


-- Age of the Youngest Customer
select
max(birthdate) as youngest_customer,
datediff(year, max(birthdate), getdate()) as age
from gold.dim_customers


-- Age of the Oldest Customer
select
min(birthdate) as oldest_customer,
datediff(year, min(birthdate), getdate()) as age
from gold.dim_customers