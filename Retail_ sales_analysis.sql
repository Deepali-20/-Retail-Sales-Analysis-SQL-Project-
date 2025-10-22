DROP TABLE IF EXISTS Retailer_Sale;
CREATE TABLE Retailer_sale(
transactions_id	INT,
sale_date DATE,
sale_time TIME,	
customer_id	INT,
gender	VARCHAR(15),
age	INT,
category VARCHAR(15),	
quantiy	INT,
price_per_unit	FLOAT,
cogs	FLOAT,
total_sale FLOAT

);
SELECT * FROM Retailer_sale;

SELECT COUNT(*) FROM Retailer_sale;
SELECT *
FROM Retailer_sale
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantiy IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
--- DATA CLEANING  
DELETE  FROM Retailer_sale 
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantiy IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;

--- DATA PREPROCESSING
--- HOW MANY SALES IS THERE
SELECT COUNT(*)  AS total_count FROM Retailer_sale;
--- how many UNIQUE customer we have
SELECT COUNT(DISTINCT(customer_id )) AS Total_customer FROM Retailer_sale;
--- how many UNIQUE cATOGRY we have
SELECT COUNT(DISTINCT(category )) AS Total_cATEOGRY FROM Retailer_sale;
SELECT DISTINCT(category ) AS Total_cATEOGRY FROM Retailer_sale;

---DATA ANALYSIS AND BUSISNESS ANALYSIS PROBLEM
-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT * FROM Retailer_sale WHERE sale_date ='2022-11-05';
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
SELECT * FROM Retailer_sale 
WHERE category = 'Clothing' AND quantiy >=4 AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category,SUM(Total_sale) AS Total_sale FROM Retailer_sale GROUP BY category;  
--- or other methods
SELECT
	CATEGORY,
	ROUND(AVG(AGE),2)
FROM
	RETAILER_SALE
GROUP BY
	CATEGORY
ORDER BY
	CATEGORY
LIMIT
	1;
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT ROUND(AVG(age),2) AS AVGERAGE_AGE FROM Retailer_sale WHERE category = 'Beauty';
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM Retailer_sale WHERE Total_sale > 1000;
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT gender, category ,COUNT(*) AS total_sum
FROM Retailer_sale GROUP BY gender ,category ORDER BY 1;
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT 
    TO_CHAR(sale_date, 'Month') AS sale_month,
    AVG(total_sale) AS average_sale,
    MAX(total_sale) AS best_selling
FROM Retailer_sale
GROUP BY TO_CHAR(sale_date, 'Month')
ORDER BY MIN(sale_date);
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT customer_id , SUM(total_sale) AS total_sale 
FROM Retailer_sale group BY customer_id DESC LIMIT 5;
---Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT DISTINCT(COUNT(customer_id)) ,category FROM Retailer_sale GROUP BY  ;
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retailer_sale
GROUP BY 1, 2
) as t1
WHERE rank = 1
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_basis AS (

SELECT *,
    CASE 
	WHEN EXTRACT (HOUR  FROM sale_time) <= 12 THEN 'Morning'
	WHEN EXTRACT (HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
	ELSE 'Evening'
	END AS shift
	FROM Retailer_sale
	)
SELECT shift , COUNT(*) AS total_order
FROM hourly_basis
GROUP BY shift;

