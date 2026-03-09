---OBJECTIVE OF THIS PROJECT--
          -The Objective of this project to analyze retail sales data using SQL to identify sales trends,customer purchasing behavior 
           and product category performance by applying various SQL queries and analytical techniques.


--- SQL Retail Sales Analysis project---

CREATE DATABASE SQL_PROJECT_P2;



--- CREATE TABLE---
DROP TABLE if exists RETAIL_SALES;
CREATE TABLE RETAIL_SALES(
 transactions_id  INT PRIMARY KEY,
 sale_date	DATE, 
 sale_time	TIME,
 customer_id   INT,
 gender	VARCHAR(15),
 age	INT,
 category	VARCHAR(15),
 quantiy	INT,
 price_per_unit	FLOAT,
 cogs	FLOAT,
 total_sale INT
 );


 select *
 from retail_sales;


 select count(*)
 from retail_sales;


 
-- Data Cleaning---
SELECT * FROM retail_sales
WHERE transactions_id IS NULL;

SELECT * FROM retail_sales
WHERE sale_date IS NULL

SELECT * FROM retail_sales
WHERE sale_time IS NULL

SELECT * FROM retail_sales
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
-- 
DELETE FROM retail_sales
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
-- Data Exploration---

-- How many sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales;

-- How many uniuque customers we have ?

SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales;



---DATA ANALYSIS & BUSINESS ANALYSIS AND FINDINGS---

---1.Write a SQL query to retrieve all columns for sales made on '2022-11-05'.

SELECT *
FROM RETAIL_SALES
WHERE SALE_DATE='2022-11-05';

---2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than eqyal to 4 in the month of Nov-2022.

SELECT *
FROM RETAIL_SALES
WHERE CATEGORY='Clothing' 
AND QUANTIY>=4
AND TO_CHAR(SALE_DATE,'YYYY-MM')='2022-11';


---3.Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT SUM(TOTAL_SALE),CATEGORY,COUNT(*)
FROM RETAIL_SALES
GROUP BY CATEGORY;

---4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT AVG(AGE)
FROM RETAIL_SALES
WHERE CATEGORY='Beauty';

---5.Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT *
FROM RETAIL_SALES
WHERE TOTAL_SALE>1000;

---6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT COUNT(TRANSACTIONS_ID),GENDER,CATEGORY
FROM RETAIL_SALES
GROUP BY GENDER,CATEGORY;

---7.Write a SQL query to calculate the average sale for each month and find the best selling month in each year.
SELECT *
FROM(SELECT TO_CHAR(SALE_DATE,'YYYY') AS YEAR,
       TO_CHAR(SALE_DATE,'MM') AS MONTH,
	   AVG(TOTAL_SALE) AS AVG_SALE,
	   RANK() OVER (PARTITION BY TO_CHAR(SALE_DATE,'YYYY') ORDER BY AVG(TOTAL_SALE) DESC) AS RANK
FROM RETAIL_SALES
GROUP BY 1,2
) AS T1
WHERE RANK =1;


---8.Write a SQL query to find the top 5 customers based on the highest total sales.

SELECT CUSTOMER_ID,SUM(TOTAL_SALE) AS TOTAL_SALES
FROM RETAIL_SALES
GROUP BY CUSTOMER_ID
ORDER BY 2 DESC
LIMIT 5;


---9.Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT COUNT(DISTINCT CUSTOMER_ID),CATEGORY
FROM RETAIL_SALES
GROUP BY CATEGORY;


---10.Write a SQL query to create each shift and number of orders (Example: Morning ≤12, Afternoon between 12 & 17, Evening >17).
SELECT *,
CASE 
     WHEN TO_CHAR(SALE_TIME,'HH24')::INT <=12 THEN 'MORNING'
	 WHEN TO_CHAR(SALE_TIME,'HH24')::INT BETWEEN 12 AND 17 THEN 'AFTERNOON'
	 ELSE 'EVENING'
END AS SHIFT
FROM RETAIL_SALES;










	
 
