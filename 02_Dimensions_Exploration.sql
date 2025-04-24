
/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - To explore the structure of dimension tables.
	
SQL Functions Used:
    - DISTINCT
    - ORDER BY
===============================================================================
*/

-- Retrieving the list of Unique Countries
select distinct country
from gold.dim_customers
order by country;

-- Retrieving a list of unique categories, subcategories, and products
select distinct 
    category, 
    subcategory, 
    product_name 
from gold.dim_products
ORDER BY category, subcategory, product_name;