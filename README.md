# task8-window-functions
SQL queries for customer ranking, MOM growth, and top products analysis

# Superstore Sales Analysis

This repository contains SQL queries and analysis of the Superstore dataset using MySQL. 
The tasks cover customer sales aggregation, ranking, running totals, month-over-month (MoM) growth, 
and top product analysis using window functions.

## Files included

- task_window.sql : All SQL queries from Task 1 to Task 7 with comments
- ranked_customers.csv : Total sales and ranking of customers
- mom_growth.csv : Month-over-month sales growth
- top_products.csv : Top 3 products per category based on sales
- insights_task8.txt : Key insights from the analysis

## Key SQL Concepts Used

- Aggregation functions (SUM)
- GROUP BY
- Window functions: ROW_NUMBER(), RANK(), DENSE_RANK(), LAG()
- Common Table Expressions (CTEs)
- Ordering and ranking of data

## Insights

1. A small group of customers contributes a large portion of total sales.  
2. Monthly sales show seasonal trends with growth and decline in specific months.  
3. Top 3 products in each category generate the majority of revenue, highlighting priority items.
