-- import csv data into the database
create database superstore;
use superstore;

-- Total sales per customers
SELECT
    customer_id,
    customer_name,
    SUM(Sales) AS total_sales
FROM superstore_data
GROUP BY customer_id, customer_name
ORDER BY total_sales DESc;

-- Ranking Customers by sales
SELECT
    Region,
    customer_id,
    customer_name,
    SUM(Sales) AS total_sales,
    ROW_NUMBER() OVER (
        PARTITION BY Region
        ORDER BY SUM(Sales) DESC
    ) AS region_rank
FROM superstore_data
GROUP BY Region, customer_id, Customer_name;

-- Rank VS Dense Rank
SELECT
    Region,
    customer_name,
    SUM(Sales) AS total_sales,
    RANK() OVER (
        PARTITION BY Region
        ORDER BY SUM(Sales) DESC
    ) AS rank_result,
    DENSE_RANK() OVER (
        PARTITION BY Region
        ORDER BY SUM(Sales) DESC
    ) AS dense_rank_result
FROM superstore_data
GROUP BY Region, customer_name;

-- Running Total
SELECT
    Order_Date,
    SUM(Sales) AS daily_sales,
    SUM(SUM(Sales)) OVER (
        ORDER BY Order_Date
    ) AS running_total
FROM superstore_data
GROUP BY Order_Date
ORDER BY Order_Date;

-- MoM growth
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(Order_Date, '%Y-%m-01') AS month,
        SUM(Sales) AS total_sales
    FROM superstore_data
    GROUP BY month
)
SELECT
    month,
    total_sales,
    LAG(total_sales) OVER (ORDER BY month) AS prev_month_sales,
    total_sales - LAG(total_sales) OVER (ORDER BY month) AS mom_growth
FROM monthly_sales
ORDER BY month;

-- Top 3 products per category using dense_rank()
WITH product_sales AS (
    SELECT
        Category,
        `Product Name`,
        SUM(Sales) AS total_sales,
        DENSE_RANK() OVER (
            PARTITION BY Category
            ORDER BY SUM(Sales) DESC
        ) AS product_rank
    FROM superstore_data
    GROUP BY Category, `Product Name`
)
SELECT *
FROM product_sales
WHERE product_rank <= 3;

-- Top 3 products per category 
WITH product_sales AS (
    SELECT
        category,
        `Product Name`,
        SUM(sales) AS total_sales,
        DENSE_RANK() OVER (
            PARTITION BY category
            ORDER BY SUM(sales) DESC
        ) AS rnk
    FROM superstore_data
    GROUP BY category, 
`Product Name`
)
SELECT
    category,
    `Product Name`,
    total_sales
FROM product_sales
WHERE rnk <= 3
ORDER BY category, total_sales DESC;


