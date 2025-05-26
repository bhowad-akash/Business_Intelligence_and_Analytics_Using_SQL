/* Performance Analysis 
(Comparing the performance of the Current Value with the Target Value
Helps measuring the success and compare the performance)

Analysing the yearly performance of the product by comparing their sales to both its average sales performance
and the previous year sales 

*/

with Yearly_Product_Sales as
(
select year(Sales.order_date) as Order_Year, Products.product_name as Product_Name, sum(Sales.sales_amount) as Current_Sales
from gold.dim_products as Products
join gold.fact_sales as Sales
on Products.product_key = Sales.product_key
where year(Sales.order_date) is not null
group by year(Sales.order_date), Products.Product_Name
)
select 
Order_Year, 
Product_Name, 
Current_Sales,
avg(Current_Sales) over (partition by Product_Name) as Average_Sales,
Current_Sales - avg(Current_Sales) over (partition by Product_Name) as	Diff_Avg_Sales,
case 
when Current_Sales - avg(Current_Sales) over (partition by Product_Name) > 0 then 'Above_Average'
when Current_Sales - avg(Current_Sales) over (partition by Product_Name) < 0 then 'Below_Average'
else 'Average'
end Average_Change,
--- YoY Analysis
lag(Current_Sales) over (partition by Product_Name order by Order_Year) as PY_Sales,
Current_Sales - lag(Current_Sales) over (partition by Product_Name order by Order_Year) as Diff_YoY_Sales,
case
when Current_Sales - lag(Current_Sales) over (partition by Product_Name order by Order_Year) < 0 then 'Decline'
when Current_Sales - lag(Current_Sales) over (partition by Product_Name order by Order_Year) > 0 then 'Growth'
else 'No Change'
end YoY_Change
from Yearly_Product_Sales
order by Product_Name, Order_Year;