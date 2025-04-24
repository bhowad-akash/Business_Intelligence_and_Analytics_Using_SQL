/*
===============================================================================
Magnitude Analysis
===============================================================================
Purpose:
    - To quantify data and group results by specific dimensions.
    - For understanding data distribution across categories.

SQL Functions Used:
    - Aggregate Functions: SUM(), COUNT(), AVG()
    - GROUP BY, ORDER BY
===============================================================================
*/


use DataWarehouseAnalytics

-- The total number of customers by Countries
select country, count(distinct(customer_key)) as total_customers
from gold.dim_customers
group by country
order by total_customers desc;


-- The total number of customers by Gender
select gender, count(distinct(customer_key)) as total_customers
from gold.dim_customers
group by gender
order by total_customers desc;


-- The total number of products by category
select category, count(distinct(product_key)) as total_products
from gold.dim_products
group by category
order by total_products desc;


-- The average cost in each category
select category, AVG(cost) as average_cost
from gold.dim_products
group by category
order by average_cost desc;


-- The total revenue generated for each category
select gold.dim_products.category, sum(gold.fact_sales.sales_amount) as total_revenue
from gold.fact_sales
left join gold.dim_products
on gold.fact_sales.product_key = gold.dim_products.product_key
group by gold.dim_products.category
order by total_revenue desc;


-- The total revenue generated for each customer
select gold.dim_customers.customer_key, gold.dim_customers.first_name, gold.dim_customers.last_name,  sum(gold.fact_sales.sales_amount) as total_revenue
from gold.fact_sales
left join gold.dim_customers
on gold.fact_sales.customer_key = gold.dim_customers.customer_key
group by gold.dim_customers.customer_key, gold.dim_customers.first_name, gold.dim_customers.last_name
order by total_revenue desc;


-- Distribution of sold items across countries
select gold.dim_customers.country, sum(gold.fact_sales.quantity) as total_sold_items
from gold.fact_sales
left join gold.dim_customers
on gold.fact_sales.customer_key = gold.dim_customers.customer_key
group by gold.dim_customers.country
order by total_sold_items desc;