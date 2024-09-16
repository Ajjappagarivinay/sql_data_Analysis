SELECT count(*) as total_rows FROM sql_project_2.retail_sales;
-- DATA CLEANING


select * from sql_project_2.retail_sales where transactions_id is null;
select * from sql_project_2.retail_sales where sale_date is null;
select * from sql_project_2.retail_sales where sale_time is null;
select * from sql_project_2.retail_sales 
where 
	transactions_id is null 
    or
    sale_date is null
    or
    sale_time is null
    or
    customer_id is null
    or
    gender is null
    or
    category is null
    or
	quantity is null
    or
    price_per_unit is null
    or
    cogs is null
    or
    total_sale is null;
    
DELETE FROM sql_project_2.retail_sales 
WHERE 
	transactions_id IS NULL
    OR sale_date IS NULL
    OR sale_time IS NULL
    OR customer_id IS NULL
    OR gender IS NULL
    OR category IS NULL
    OR quantity IS NULL
    OR price_per_unit IS NULL
    OR cogs IS NULL
    OR total_sale IS NULL;
    
-- DATA EXPLORATION

-- HOW MANY SALES WE HAVE?

select count(*) as total_sales from sql_project_2.retail_sales;

-- HOW MANY CUSTOMERS WE HAVE?

select count(distinct customer_id) as total_customers from sql_project_2.retail_sales;

-- HOW MANY CATEGORIES ARE IN THIS SALES DATA?

select distinct category from sql_project_2.retail_sales;

-- DATA ANALYSIS & BUSINESS KEY PROBLEMS & ANSWERS
-- My Analysis & Findings

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05' ?

select * from sql_project_2.retail_sales 
where sale_date = '2022-11-05'; 

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022 ?

select * from sql_project_2.retail_sales 
where category = 'Clothing'
and  DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
and quantity >= 4;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select category,
sum(total_sale) as total_sales,
count(*) as total_orders 
from sql_project_2.retail_sales 
group by category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select round(avg(age),2) as avg_age
from sql_project_2.retail_sales 
where category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * from  sql_project_2.retail_sales 
where total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select category,gender, 
count(*) as total_transactions
from sql_project_2.retail_sales 
group by gender,category
order by category;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT * 
FROM (
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        ROUND(AVG(total_sale), 2) AS avg_sale,
        RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY ROUND(AVG(total_sale), 2) DESC) AS ranking
    FROM sql_project_2.retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS t1
WHERE ranking = 1;


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select customer_id,
	sum(total_sale) as net_sales
from  sql_project_2.retail_sales
group by customer_id
order by net_sales desc limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select category,
count(distinct customer_id) as unique_customers
from sql_project_2.retail_sales
group by category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
with cte as
	(select *,
		case
			when hour(sale_time) < 12 then 'Morning'
			when hour(sale_time) between 12 and 17 then 'Afternoon'
			else 'Evening'
		end as shift
	 from sql_project_2.retail_sales)
select shift,
	count(*) as total_orders
from cte
group by shift;

























    
    
    
    