# -Retail-Sales-Analysis-SQL-Project-
This project demonstrates how to design, clean, and analyze retail sales data using **SQL**.  
Welcome to the **Retail Sales Analysis Project**!  
This project demonstrates how to design, clean, and analyze retail sales data using **SQL**.  
It includes:
- 🧱 Database creation and cleaning  
- 🧹 Data preprocessing  
- 📈 Business & analytical SQL queries  
- 💡 Key insights for retail operations  

---

## 🧾 Table of Contents
- [Overview](#overview)
- [Database Schema](#database-schema)
- [Data Cleaning & Preprocessing](#data-cleaning--preprocessing)
- [Analysis Queries](#analysis-queries)
- [Key Learnings](#key-learnings)
- [Technologies Used](#technologies-used)
- [Author](#author)

---

## 🗂️ Overview

The **Retailer_Sale** table stores all transactional data for a retail store,  
including customer demographics, sales date/time, category, and revenue details.

| Column | Description |
|--------|--------------|
| transactions_id | Unique ID for each transaction |
| sale_date | Date of sale |
| sale_time | Time of sale |
| customer_id | Unique customer identifier |
| gender | Gender of the customer |
| age | Customer’s age |
| category | Product category |
| quantiy | Quantity of items purchased |
| price_per_unit | Unit price of product |
| cogs | Cost of goods sold |
| total_sale | Total sale value |

---

## 🏗️ Database Schema

<details>
<summary>📜 Click to view SQL schema</summary>

```sql
DROP TABLE IF EXISTS Retailer_Sale;

CREATE TABLE Retailer_Sale(
    transactions_id INT,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantiy INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);

-- View table
SELECT * FROM Retailer_Sale;
</details>
🧹 Data Cleaning & Preprocessing
<details> <summary>🧽 Click to view data cleaning and preprocessing steps</summary>
sql
Copy code
-- 1️⃣ Count total records
SELECT COUNT(*) FROM Retailer_Sale;

-- 2️⃣ Check for NULL or missing values
SELECT *
FROM Retailer_Sale
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

-- 3️⃣ Delete missing records
DELETE FROM Retailer_Sale 
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

-- 4️⃣ Data Preprocessing
-- Total sales count
SELECT COUNT(*) AS total_count FROM Retailer_Sale;

-- Unique customers
SELECT COUNT(DISTINCT(customer_id)) AS Total_customers FROM Retailer_Sale;

-- Unique product categories
SELECT COUNT(DISTINCT(category)) AS Total_categories FROM Retailer_Sale;
SELECT DISTINCT(category) AS Category_List FROM Retailer_Sale;
</details>
📊 Analysis Queries
<details> <summary>🧠 Click to view business and analytical queries</summary>
sql
Copy code
-- Q1️⃣ Retrieve all columns for sales made on '2022-11-05'
SELECT * FROM Retailer_Sale WHERE sale_date = '2022-11-05';

-- Q2️⃣ Transactions where the category is 'Clothing' and quantity sold > 10 (Nov 2022)
SELECT * FROM Retailer_Sale
WHERE category = 'Clothing'
  AND quantiy > 10
  AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';

-- Q3️⃣ Total sales (total_sale) for each category
SELECT category, SUM(total_sale) AS Total_Sales
FROM Retailer_Sale
GROUP BY category;

-- Q4️⃣ Average age of customers who purchased from 'Beauty' category
SELECT ROUND(AVG(age), 2) AS Average_Age
FROM Retailer_Sale
WHERE category = 'Beauty';

-- Q5️⃣ All transactions where total_sale > 1000
SELECT * FROM Retailer_Sale WHERE total_sale > 1000;

-- Q6️⃣ Total number of transactions by gender in each category
SELECT gender, category, COUNT(*) AS Total_Transactions
FROM Retailer_Sale
GROUP BY gender, category
ORDER BY gender;

-- Q7️⃣ Average sale per month and best-selling month each year
SELECT 
    TO_CHAR(sale_date, 'Month') AS sale_month,
    AVG(total_sale) AS average_sale,
    MAX(total_sale) AS best_selling
FROM Retailer_Sale
GROUP BY TO_CHAR(sale_date, 'Month')
ORDER BY MIN(sale_date);

-- Q8️⃣ Top 5 customers based on highest total sales
SELECT customer_id, SUM(total_sale) AS Total_Sales
FROM Retailer_Sale
GROUP BY customer_id
ORDER BY Total_Sales DESC
LIMIT 5;

-- Q9️⃣ Unique customers who purchased items from each category
SELECT category, COUNT(DISTINCT(customer_id)) AS Unique_Customers
FROM Retailer_Sale
GROUP BY category;

-- Q🔟 Categorize orders by shift: Morning (<=12), Afternoon (12–17), Evening (>17)
WITH hourly_basis AS (
    SELECT *,
        CASE 
            WHEN EXTRACT(HOUR FROM sale_time) <= 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM Retailer_Sale
)
SELECT shift, COUNT(*) AS total_orders
FROM hourly_basis
GROUP BY shift;
🧮 Insights Generated

✨ Total sales count and number of customers
✨ Best-selling product categories
✨ Age-wise and gender-based purchase patterns
✨ Monthly revenue trends
✨ Shift-wise sales performance (Morning, Afternoon, Evening)
✨ Top 5 high-value customers
