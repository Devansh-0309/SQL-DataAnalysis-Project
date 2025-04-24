/*
===============================================================
Customer Report
===============================================================
Purpose:
	This report consolidates key customer metrics and behaviour

Highlights:
	1. Gather essential fields such as names, ages, and transaction details.
	2. Segments customer into categories (VIP, Regular, New) and age groups.
	3. Aggregates customer-level metrics:
		- total orders
		- total quantity purchased
		- total products
		- lifespan (in months)
	4. Calculates valueable KPIs:
		- recency (months since last order)
		- average order value
		- average monthly spend
===============================================================
*/

WITH base_query AS(
/*
---------------------------------------------------------------
1. Retreive core columns from the tables
---------------------------------------------------------------
*/
SELECT
c.customer_key,
c.customer_number,
CONCAT(c.first_name,' ',c.last_name) AS customer_name,
DATEDIFF(year,c.birth_date,GETDATE()) AS age,
f.order_number,
f.product_key,
f.sales,
f.quantity,
f.order_date
FROM Gold.fact_sales AS f
LEFT JOIN Gold.dim_customers AS c
ON f.customer_key = c.customer_key
WHERE order_date IS NOT NULL
)
, customer_aggregations AS (
/*
-------------------------------------------------------------------
2. perform customer aggregatons like total sales , total quantity, age etc
-------------------------------------------------------------------
*/
SELECT 
customer_key,
customer_number,
customer_name,
age,
COUNT(DISTINCT order_number) AS total_orders,
COUNT(DISTINCT product_key) AS total_products,
SUM(sales) AS total_sales,
SUM(quantity) AS total_quantity,
MAX(order_date) AS last_order,
DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan
FROM base_query
GROUP BY
	customer_key,
	customer_number,
	customer_name,
	age
)

SELECT 
customer_key,
customer_number,
customer_name,
age,
CASE 
	WHEN age > 55 THEN 'old'
	WHEN age > 30 THEN 'Adult'
	WHEN age > 20 THEN 'Teenage'
	ELSE 'child'
END AS age_group,
total_orders,
total_products,
total_sales,
total_quantity,
lifespan,
CASE 
	WHEN lifespan >= 12 AND total_sales > 5000 THEN 'VIP'
	WHEN lifespan >= 12 AND total_sales <= 5000 THEN 'Regular'
	ELSE 'New'
END AS customer_type,
last_order,
DATEDIFF(month, last_order, GETDATE()) AS recency_order_months,
-- Average order value
CASE 
	WHEN total_orders = 0 THEN 0
	ELSE total_sales / total_orders
END AS avg_order_value,

-- Average monthly spend
CASE 
	WHEN lifespan = 0 THEN total_sales
	ELSE total_sales / lifespan
END AS avg_monthly_spend
FROM customer_aggregations
GO


