/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - To rank items (e.g., products, customers) based on performance or other metrics.
    - To identify top performers or laggards.

SQL Functions Used:
    - Window Ranking Functions: RANK(), DENSE_RANK(), ROW_NUMBER(), TOP
    - Clauses: GROUP BY, ORDER BY
===============================================================================
*/


use DataWarehouseAnalytics

-- 5 Product Subctegories that generate the highest revenue
select top 5
gold.dim_products.subcategory, sum(gold.fact_sales.sales_amount) as revenue
from gold.fact_sales
left join gold.dim_products
on gold.fact_sales.product_key = gold.dim_products.product_key
group by dim_products.subcategory
order by revenue desc;


-- 5 Product Subctegories that generate the highest revenue (Using Window Functions)
SELECT *
FROM (
    SELECT
        gold.dim_products.subcategory,
        SUM(gold.fact_sales.sales_amount) AS total_revenue,
        RANK() OVER (ORDER BY SUM(gold.fact_sales.sales_amount) DESC) AS rank_products
    FROM gold.fact_sales
    LEFT JOIN gold.dim_products
        ON gold.fact_sales.product_key = gold.dim_products.product_key
    GROUP BY gold.dim_products.subcategory
) AS ranked_products
WHERE rank_products <= 5;


-- 5 Product Subcategories that generate the lowest revenue
select top 5
gold.dim_products.subcategory, sum(gold.fact_sales.sales_amount) as revenue
from gold.fact_sales
left join gold.dim_products
on gold.fact_sales.product_key = gold.dim_products.product_key
group by dim_products.subcategory
order by revenue asc;


-- Top 10 Customers that generated the highest revenue
select top 10
gold.dim_customers.first_name, gold.dim_customers.last_name, sum(gold.fact_sales.sales_amount) as revenue
from gold.fact_sales
left join gold.dim_customers
on gold.fact_sales.customer_key = gold.dim_customers.customer_key
group by gold.dim_customers.first_name, gold.dim_customers.last_name
order by revenue desc;


-- Top 10 Customers that generated the highest revenue
select top 10
gold.dim_customers.first_name, gold.dim_customers.last_name, sum(gold.fact_sales.sales_amount) as revenue
from gold.fact_sales
left join gold.dim_customers
on gold.fact_sales.customer_key = gold.dim_customers.customer_key
group by gold.dim_customers.first_name, gold.dim_customers.last_name
order by revenue desc;


-- 3 Customers with the fewst orders placed
select top 3
gold.dim_customers.first_name, gold.dim_customers.last_name, count(distinct(gold.fact_sales.order_number)) as orders_placed
from gold.fact_sales
left join gold.dim_customers
on gold.fact_sales.customer_key = gold.dim_customers.customer_key
group by gold.dim_customers.first_name, gold.dim_customers.last_name
order by orders_placed asc;