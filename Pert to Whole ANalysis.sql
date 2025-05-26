/* Part to Whole Analysis

This helps to analyse howq the individual part is performing compared to the overall,
which allows to understand which category has the greatest impact on the business. */

-- Which categories contribute to the overall sales

with category_sales as 
(
select Products.category as Product_Category, sum(Sales.sales_amount) as Total_Category_Sales
from gold.dim_products as Products
left join gold.fact_sales as Sales
on Products.product_key = Sales.product_key 
where Products.category is not null
group by Products.category
)
select Product_Category, 
Total_Category_Sales,
sum(Total_Category_Sales) over() as Overall_Sales,
concat(round((cast (Total_Category_Sales as float) / sum(Total_Category_Sales) over()) * 100, 2), '%') as Percent_Share
from category_sales
order by Total_Category_Sales desc;