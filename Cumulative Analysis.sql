use DataWarehouseAnalytics

/* Cumulative Analysis */

/* 

Difference between Normal and Cumulative Aggregations

If we want to see how the business is performing each year then one would do the Normal Aggregations.
However if we would like to see how business is progressing/growing over the years then we would do Cumulative Aggregations.



 
-- Calculating the total sales per month
select datetrunc(MONTH, order_date) as Order_Date, sum(sales_amount) as Total_Sales
from gold.fact_sales
where order_date is not	null
group by datetrunc(MONTH, order_date)
order by datetrunc(MONTH, order_date);

-- Calculating running total sales over time (Using Window Function)
select Order_Date,
Total_Sales,
sum(Total_Sales) over (order by(Order_Date)) as Running_Total_Sales
from
(
select datetrunc(MONTH, order_date) as Order_Date, sum(sales_amount) as Total_Sales
from gold.fact_sales
where order_date is not	null
group by datetrunc(MONTH, order_date)
) t

-- Calculating running total sales over time by Partitioning the Data for each year (Using Window Function)
select Order_Date,
Total_Sales,
sum(Total_Sales) over (partition by year(Order_Date) order by Order_Date) as Running_Total_Sales
from
(
select datetrunc(MONTH, order_date) as Order_Date, sum(sales_amount) as Total_Sales
from gold.fact_sales
where order_date is not	null
group by datetrunc(MONTH, order_date)
) t

-- Calculating Moving Average over time by Partitioning the Data for each year (Using Window Function)
select Order_Date,
Total_Sales,
Average_Sales,
sum(Total_Sales) over (partition by year(Order_Date) order by Order_Date) as Running_Total_Sales,
avg(Average_Sales) over (partition by year(Order_Date) order by Order_Date) as Moving_Average_Sales
from
(
select datetrunc(MONTH, order_date) as Order_Date, sum(sales_amount) as Total_Sales, AVG(sales_amount) as Average_Sales
from gold.fact_sales
where order_date is not	null
group by datetrunc(MONTH, order_date)
) t