/*

Retail Sales Analysis Report

1. Introduction

This report provides an in-depth analysis of retail sales transactions based on the given dataset. It includes insights into sales trends, customer demographics, and product category performance using SQL queries.

2. Data Overview

The dataset consists of 2000 records and 11 attributes, covering transaction details such as sale date, time, customer ID, gender, age, category, quantity, price per unit, cost of goods sold (COGS), and total sales.

2.1 Data Quality Check

The dataset contains missing values in age, quantity, price_per_unit, cogs, and total_sale columns.

The sale date is formatted as DD-MM-YY.

The category column includes different product types like Clothing, Beauty, etc.

3. Key Findings

3.1 Total Sales and Customers

Total Transactions: 2000

Total Unique Customers: (Derived from count(distinct customer_id))

3.2 Sales Performance by Category

The highest total sales were recorded in the Clothing category.

Top 3 Selling Categories (by revenue): (Derived from sum(total_sale) group by category)

Clothing

Beauty

(Other category as per dataset)

3.3 Monthly Sales Trends

The best-selling month in each year was calculated using avg(total_sale) group by year(sale_date), month(sale_date).

Peak sales occurred in (Top-selling month) month.

3.4 Customer Demographics

Average age of customers in the Beauty category: (Derived from avg(age) group by gender)

Majority of customers fall into the (age range).

Gender distribution: Male vs Female transaction ratio (Derived from count(*) group by gender).

3.5 High-Value Transactions

Transactions above 1000 in sales: (Derived from where total_sale >=1000)

Top 5 Customers by Total Sales: (From group by customer_id order by total_sale desc limit 5)

3.6 Sales by Time of Day

Transactions were categorized into Morning, Afternoon, Evening, and Night.

Highest number of transactions occurred in the (Shift) shift.

4. Conclusion

This analysis highlights key trends in retail sales, including top-selling categories, peak sales periods, customer demographics, and high-value transactions. These insights can be leveraged for inventory planning, targeted marketing, and customer engagement strategies.

5. Recommendations

Address missing values in quantity, price_per_unit, and total_sale for better accuracy.

Focus marketing efforts on top-selling months to maximize revenue.

Optimize stock for high-selling product categories.

Target high-value customers for loyalty programs.





*/