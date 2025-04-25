/*
==================================================
Product Report
==================================================

Purpose:
	This report consolidates key product metrics and behaviour

Highlights:
	1. Gathers essential fields such as product name, category, subcategory and cost.
	2. Segments product by revenue to identify high performance, Mid-range or low performannce.
	3. Aggregates product-level Metrics:
		- total orders
		- total sales
		- total quantity sold
		- lifespan in months
	4. Calculates valuable KPIs:
		- recency (month since last sales)
		- average order revenue
		- average monthly revenue
*/
CREATE VIEW Gold.products_report AS 

/*
--------------------------------------------------------------------
1). first intermediate query to gather all the necessary columns. 
--------------------------------------------------------------------
*/
WITH base_query AS (
SELECT 
f.order_number,
f.order_date,
f.customer_key,
f.sales,
f.quantity,
p.product_key,
p.product_name,
p.category_id,
p.sub_category,
p.cost
FROM Gold.fact_sales AS f
LEFT JOIN Gold.dim_products AS p
ON f.product_key = p.product_key
WHERE order_date IS NOT NULL
),

/*
--------------------------------------------------------------------
2). Second intermediate query to perform product aggregations. 
--------------------------------------------------------------------
*/

product_aggregations AS (
SELECT	
	product_key,
	product_name,
	category_id,
	sub_category,
	cost,
	DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan,
	MAX(order_date) AS last_sale_order,
	SUM(sales) AS total_sales,
	COUNT(DISTINCT order_number) AS total_orders,
	COUNT(DISTINCT customer_key) AS total_customers,
	SUM(quantity) AS total_quantity,
	ROUND(AVG(CAST(sales AS FLOAT) / NULLIF(quantity, 0)), 1) AS avg_selling_price
FROM base_query	
GROUP BY
	product_key,
	product_name,
	category_id,
	sub_category,
	cost
)
/*
--------------------------------------------------------------------
3). Final query to fetch the details. 
--------------------------------------------------------------------
*/
SELECT 
 product_key,
 product_name,
 category_id,
 sub_category,
 cost,
 last_sale_order,
 DATEDIFF(MONTH, last_sale_order, GETDATE()) AS recent_order_months,
 CASE 
	WHEN total_sales > 50000 THEN 'High'
	WHEN total_sales >= 10000 THEN 'Mid'
	ELSE 'Low'
END AS product_performance,
total_sales,
total_orders,
total_customers,
avg_selling_price,

-- Average order revenue
CASE 
	WHEN total_orders = 0 THEN 0
	ELSE total_sales / total_orders
END AS avg_order_revenue,

-- Average monthly revenue
CASE 
	WHEN lifespan = 0 THEN total_sales
	ELSE total_sales / lifespan
END AS avg_monthly_revenue
FROM product_aggregations;