/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), AVG()
===============================================================================
*/

use DataWarehouseAnalytics

-- Total Sales
select SUM(sales_amount) as total_sales
from gold.fact_sales;


-- How many items are sold
select count(distinct(product_number)) as items_sold 
from gold.dim_products;


-- Average Selling Price
select AVG(price) as average_selling_price
from gold.fact_sales;


-- Total number of Orders
select count(distinct(order_number)) as total_orders
from gold.fact_sales;


-- Total number of products
select count(distinct(product_key)) as total_products
from gold.dim_products;


-- Total number of customers
select count(customer_id) as total_customers
from gold.dim_customers;


-- Total number of customers that has placed an order
select count(distinct(customer_key)) as total_customers_who_placed_orders 
from gold.fact_sales;


-- Report that shows all key metrics of the business
select 'Total Sales' as measure_name, SUM(sales_amount) as measure_value 
from gold.fact_sales
union all
select 'Total Quantity', SUM(quantity)
from gold.fact_sales
union all
select 'Average price', AVG(price)
from gold.fact_sales
union all
select 'Total Nr. of Orders', count(distinct(order_number))
from gold.fact_sales
union all
select 'Total Nr. of Products', count(distinct(product_key))
from gold.dim_products
union all
select 'Total Nr. of Customers', count(customer_id)
from gold.dim_customers