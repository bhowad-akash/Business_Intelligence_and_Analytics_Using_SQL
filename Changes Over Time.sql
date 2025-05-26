-- Trends and Changes over Tinme

-- Analysing Sales Performance over Time
select year(order_date) as Year,
month(order_date) as Month,
sum(sales_amount) as Total_Sales,
count(distinct(customer_key)) as Total_Customers,
SUM(quantity) as Total_Quantity
from gold.fact_sales
where month(order_date) is not null
group by year(order_date), month(order_date)
order by year(order_date), month(order_date);

-- Analysing Sales Performance over Time (Using Date_Trunc) function (By Month)
select datetrunc(month, order_date) as Month,
sum(sales_amount) as Total_Sales,
count(distinct(customer_key)) as Total_Customers,
SUM(quantity) as Total_Quantity
from gold.fact_sales
where month(order_date) is not null
group by datetrunc(month, order_date)
order by datetrunc(month, order_date);

-- Analysing Sales Performance over Time (Using Date_Trunc) function By Year
select datetrunc(year, order_date) as Year,
sum(sales_amount) as Total_Sales,
count(distinct(customer_key)) as Total_Customers,
SUM(quantity) as Total_Quantity
from gold.fact_sales
where month(order_date) is not null
group by datetrunc(year, order_date)
order by datetrunc(year, order_date);

-- Analysing Sales Performance over Time (Specific Preference - Format function)
select format(order_date, 'yyyy-MMM') as Month,
sum(sales_amount) as Total_Sales,
count(distinct(customer_key)) as Total_Customers,
SUM(quantity) as Total_Quantity
from gold.fact_sales
where month(order_date) is not null
group by format(order_date, 'yyyy-MMM')
order by format(order_date, 'yyyy-MMM');