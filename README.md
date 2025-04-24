# SQL-DataAnalysis-Project

## Overview
Data Analysis is used to get the insights about the buisness. This helps us to understand the key features affecting the buisness.

## Techniques

### 1. Change Over Time Analysis
This is a technique where we find out the trends in the buisness growing with time. for e.g sales by year
We use the formuale [**Measure**] By [**Date Dimension**]

### 2. Cumulative Analysis
This is a technique where we find the measures progressing over time. for e.g running total by sales
We use the formulae [**Cumulative Measure**] By [**Date Dimension**]

### 3. Performance Analysis
This is a technique where we compare the current value of a part to its target value. for e.g current sales by previous sales
We use the formulae [**Current Measure**] By [**target Measure**]

### 4. Part To Whole Analysis
This is a technique where we compare a part of the measure to the whole part. for e.g particular category total contribution
We use the formulae ([**Measure**] / [**Total Measure**]) * 100 By [**Dimension**]

### 5. Data Segmentation
This is a technique Where we segment the measures to a dimension and then perform analysis on that. For e.g segment customers to (VIP, regular etc.)
We use two [**Measure**] By [**Measure**]

## **Data Catalog**

## Overview
Data catalog is the short description of the data which is used to increase the readability of the code and helps the viewers to get a better understanding about the data before processing it. 

## 1. Gold.dim_customers
**Purpose**: Stores all details about the customers.
**Columns**: 

| Column        | Data Type                  | Description     |
|----------------|------------------------------|------------|
| customer_key   | INT       | Contains user defined unique indentifier e.g (1,2,3,...)|
| customer_id | INT   | Contains customer_id e.g (11000, 11001 ,....)   |
| customer_number | NVARCAHR(30)     | Contains customer number e.g (AW00011000) |
| first_name | NVARCHAR(30)| Contains the first name of the customer e.g (jon)|
| last_name | NVARCHAR(30)| Contains the last name of the customer e.g (yang)|
| country | NVARCHAR(30)| Contains the country origin of the customer e.g (Australia, France etc.)|
| marital_status | NVARCHAR(30)| Contains the marital status e.g (Married, Single, n/a)|
| gender | NVARCHAR(30)| Contains the gender of the customer e.g (Male, Female, n/a)|
| birth_date | DATE| Contains the birth date of the customer in 'YYYY-MM-DD' format |
| create_date | DATE | Contains the creation date of the customer when the id is created in 'YYYY-MM-DD' format|

## 2. Gold.dim_products
**Purpose**: Stores all details about the products.
**Columns**: 

| Column        | Data Type                  | Description     |
|----------------|------------------------------|------------|
| product_key   | INT       | Contains user defined unique indentifier e.g (1,2,3,...)|
| product_id | INT   | Contains product id e.g (210, 211 ,....)   |
| product_number | NVARCAHR(30)     | Contains product number e.g (FR-R92B-58) |
| product_name | NVARCHAR(40)| Contains the product name  e.g (Road-450 Red-48)|
| category_id | NVARCHAR(30)| Contains the category id of product e.g (BI_RB)|
| category | NVARCHAR(30)| Contains the category of products e.g (Bikes etc.)|
| sub_category | NVARCHAR(30)| Contains the sub category of product (Road Bikes etc.)|
| maintenance | NVARCHAR(30)| Contains maintenance category (NULL, Yes, No)|
| cost | INT | Contains the cost of the product |
| product_line | NVARCHAR(30) | Contains the product line e.g(Mountain, n/a etc.)|
| start_date | DATE | Contains the start date of the products in 'YYYY-MM-DD' format|

## 3. Gold.fact_sales
**Purpose**: Stores all details about the fact table sales.
**Columns**: 

| Column        | Data Type                  | Description     |
|----------------|------------------------------|------------|
| order_number   | NVARCHAR(30) | Contains unique indentifier e.g (SO43679)|
| product_key | INT   | Contains the product key integrated from dim_products view e.g(1,20,..) |
| customer_key | INT     | Contains customer key integrated with dim_customers e.g (10769,...)|
| sales | INT| Contains the sales of the product i.e (quantity/price))|
| quantity | INT | Contains the Quantity of the product purchased |
| price | INT | Contains the price of the product i.e ABS(sales) * quantity |
| order_date | DATE | Contains the order date in 'YYYY-MM-DD' format|
| ship_date | DATE | Contains the shipping date in 'YYYY-MM-DD' format|
| due_date | DATE | Contains the due date in 'YYYY-MM-DD' format|
## License
This project has a MIT license that means it is free to use, modify and transfer as per the requirnment.

## About Me
Hi, I am **Devansh Maheshwari**. A passionate individual who has a keen interest in data and its propeties.
