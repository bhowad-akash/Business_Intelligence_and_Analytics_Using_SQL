/* Data Segmentation

Groups the data based on a specific range.
Helps understand the correlation between two measures.

*/

-- Segment products into cost ranges and count how many products fall into each segment

with product_segments as
(
select product_key, product_name, cost,
case when cost < 100 then 'Below 100'
when cost between 100 and 500 then '100-500'
when cost between 500 and 1000 then '500-1000'
else 'Above 1000'
end Cost_Range
from gold.dim_products
)
select cost_range,
count(product_key) as Total_Products
from product_segments
group by cost_range
order by Total_Products desc;

-- Group customers into three segments based on their spending behaviour

-- VIP: At least 12 months of history and spending more than $5000
-- Regular: At least 12 months of history but spending $5000 or less
-- New: Lifespan less than 12 months
-- COunt the total number of customers by each segment

select Customers.customer_key as Customer_Key,
sum(Sales.sales_amount) as Order_Value, 
min(order_date) as First_Order_Placed,
max(order_date) as Last_Order_Placed,
DATEDIFF(month, min(order_date), max(order_date)) as Total_Lifespan,
case
when (DATEDIFF(month, min(order_date), max(order_date)) >= 12) and (sum(Sales.sales_amount)) > 5000 then 'VIP Customer'
when (DATEDIFF(month, min(order_date), max(order_date)) >= 12) and (sum(Sales.sales_amount)) <= 5000 then 'Regular Customer'
else 'New Customer'
end Customer_Segment
from gold.dim_customers as Customers
left join gold.fact_sales as Sales
on Customers.Customer_key = Sales.Customer_key
where order_date is not null
group by Customers.customer_key;


--Using CTE

with Customers_History as
(
select
Customers.customer_key as Customer_Key,
sum(Sales.sales_amount) as Order_Value, 
min(order_date) as First_Order_Placed,
max(order_date) as Last_Order_Placed,
DATEDIFF(month, min(order_date), max(order_date)) as Total_Lifespan
from gold.dim_customers as Customers
left join gold.fact_sales as Sales
on Customers.Customer_key = Sales.Customer_key
group by Customers.customer_key
)

select Customer_Segment,
count(customer_key) as Total_Customers_By_Segment
from 
(
select customer_key,
case
when Total_Lifespan >= 12 and Order_Value > 5000 then 'VIP Customer'
when Total_Lifespan >= 12 and Order_Value <= 5000 then 'Regular Customer'
else 'New Customer'
end Customer_Segment
from Customers_History
) t
group by Customer_Segment
order by Total_Customers_By_Segment desc;
