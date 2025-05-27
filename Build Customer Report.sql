-- Base Query to retrieve the core columns from tables

create view gold.report_customers as
with base_query as
-- Base Query to retrieve the core columns from tables
(
select 
	Sales.order_number,
	Sales.product_key,
	Sales.order_date,
	Sales.sales_amount,
	Sales.quantity,
	Customers.customer_key,
	Customers.customer_number,
	concat(Customers.first_name, ' ', Customers.last_name) as customer_name,
	datediff(year, birthdate, getdate()) as customer_age
from gold.fact_sales as Sales
left join gold.dim_customers as Customers
on Sales.customer_key = Customers.customer_key
where Sales.order_date is not null
)

, customer_aggregation as (

-- 2. Customer Aggregations: Summarizes aggregations at the customer level

select 
	customer_number,
	customer_name,
	customer_age,
	count(distinct order_number) as total_orders,
	sum(sales_amount) as total_sales,
	sum(quantity) as total_quantity,
	count(distinct product_key) as total_products,
	max(order_date) as last_order_date,
	DATEDIFF(month, min(order_date), max(order_date)) as total_lifespan
from base_query
group by
	customer_key,
	customer_number,
	customer_name,
	customer_age
)

select
	customer_number,
	customer_name,
	customer_age,
	total_orders,
	total_sales,
	total_quantity,
	total_products,
	last_order_date,
	total_lifespan,
	case
	when customer_age < 20 then 'Under 20'
	when customer_age between 20 and 30 then '20-29'
	when customer_age between 30 and 39 then '30-39'
	when customer_age between 40 and 49 then '40-49'
	else 'New'
	end age_group,
	case
	when total_lifespan >= 12 and total_sales > 5000 then 'VIP Customer'
	when total_lifespan >= 12 and total_sales <= 5000 then 'Regular Customer'
	else 'New Customer'
	end customer_category,
	DATEDIFF(month, last_order_date, getdate()) as recency,
	
	-- Compute Average Order Value only when we have orders. When the orders are 0 then 0.

	case
	when total_orders = 0 then 0
	else total_sales / total_orders
	end average_order_value,

	-- Compute Average Monthly Spend only when we have Months. When the Months are 0 then 0

	case
	when total_lifespan = 0 then total_sales
	else total_sales / total_lifespan
	end average_monthly_spend

from customer_aggregation;