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










create database Retails;
create table retail_sales;
use Retails;

select * from retail_sale;

select count(*) from retail_sale;

-- checking the Null Values in the records

select * from retail_sale
where ï»¿transactions_id is null
or
 sale_date is null
or
 sale_time is null
or
 customer_id is null
or
 gender is null
or
 age is null
or
 category is null
or
 quantiy is null
or
 price_per_unit is null
or
 cogs is null
or
 total_sale is null;
 
 -- fetch count of total sales
 select count(*) as total_sales from retail_sale;
 
 -- fetch count of totel customer
 
 select count(distinct(customer_id)) as total_customer from retail_sale;
 
 -- how many unique category we have
 
 select count(distinct(category)) as no_of_unique_category from retail_sale;
 
 -- show the unique category name
 
  select distinct(category) as unique_category_name from retail_sale;
  
  -- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05:

SELECT * FROM retail_sale 
WHERE sale_date = '05-11-22';

-- 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
select * from retail_sale
where category='clothing' and quantiy >=4 and month(sale_date)=11 and year(sale_date)=2022;

-- 3. Write a SQL query to calculate the total sales (total_sale) for each category.:
select category, sum(total_sale) as total_sales_in_each_category, count(*) as total_order from retail_sale group by category;

-- 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select avg(age) as avg_age, gender, category from retail_sale where category = 'Beauty' group by gender;

-- 5. Write a SQL query to find all transactions where the total_sale is greater than 1000.:
select * from retail_sale where total_sale >=1000;
  
  
  -- 6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select count(*) as total_number_of_transactions, gender, category from retail_sale group by gender, category;

-- 7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
select 
	avg(TOTAL_SALE) AS AVG_SALE,
	YEAR(SALE_DATE) AS SALE_MONTH,
    MONTH(SALE_DATE)  AS SALE_YEAR
FROM retail_SALE
group by YEAR(SALE_DATE), MONTH(SALE_DATE) order by YEAR(SALE_DATE);

-- 9. Write a SQL query to find the number of unique customers who purchased items from each category.:
select count(distinct(customer_id)) as unique_customer, category from retail_sale
group by category;
-- 8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
select
	CUSTOMER_ID,
    SUM(TOTAL_SALE) AS TOTAL_SALE
FROM retail_sale
group by CUSTOMER_ID
order by CUSTOMER_ID DESC
limit 5;

-- 10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

with hourly_sale
as(
select*,
	case
		when hour(sale_time) <12 then 'Morning'
        when hour(sale_time) between 12 and 17 then 'Afternoon'
		when hour(sale_time) between 17 and 21 then 'Evening'
        else 'Night'
	end as 'Shift'
 from retail_sale)
 select count(*) as total_transection, shift from hourly_sale 
 group by shift;
  