-- Data Exploration
-- Check all columns and datatypes in the data

SELECT *
FROM casestudy.bright.coffee_shop
LIMIT 10;


--Check all the categorical data

SELECT DISTINCT store_location
FROM casestudy.bright.coffee_shop;

--Product category 

SELECT DISTINCT product_category
FROM casestudy.bright.coffee_shop;

-- DATETIME Functions 
-- Transaction Date

SELECT MIN(transaction_date) AS First_operating_date 
FROM casestudy.bright.coffee_shop;

SELECT MAX(transaction_date) AS Last_operating_date 
FROM casestudy.bright.coffee_shop;

-- Day, Month 

SELECT transaction_date,
       MONTHNAME(transaction_date) AS month_name,
       DAYNAME(transaction_date) AS day_name
FROM casestudy.bright.coffee_shop;

-- Case Statements for classifications 

SELECT transaction_date,
       MONTHNAME(transaction_date) AS month_name,
       DAYNAME(transaction_date) AS day_name,
       
   CASE 
      WHEN day_name IN ('SAT','SUN') THEN 'Weekend'
      ELSE 'Weekday'
   END AS day_classification 
   
FROM casestudy.bright.coffee_shop;

-- Transaction Time

SELECT MIN(transaction_time) AS opening_hour
FROM casestudy.bright.coffee_shop;

SELECT MAX(transaction_time) AS closing_hour
FROM casestudy.bright.coffee_shop;

-- CASE classification Morning, Afternoon or Evening

SELECT transaction_time,
       HOUR(transaction_time) AS hour_of_day,
       
   CASE 
      WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
      WHEN transaction_time BETWEEN '12:00:00' AND '16:59:59' THEN 'Afternoon'
     WHEN transaction_time >= '17:00:00' THEN 'Evening'
   END AS time_classification 
   
FROM casestudy.bright.coffee_shop;

--Categorical Data : store_location, product_category, product_detail, product_type
-- Revenue by store location, highest selling products

SELECT store_location,
       SUM(transaction_qty * unit_price) AS revenue 
FROM casestudy.bright.coffee_shop
GROUP BY store_location;

SELECT product_category,
       SUM(transaction_qty * unit_price) AS revenue 
FROM casestudy.bright.coffee_shop
GROUP BY product_category;
      

--ID's

SELECT COUNT(DISTINCT transaction_id) AS number_of_sales
FROM casestudy.bright.coffee_shop;

SELECT COUNT(DISTINCT store_id) AS number_of_stores
FROM casestudy.bright.coffee_shop;

SELECT COUNT(DISTINCT product_id) AS number_of_products
FROM casestudy.bright.coffee_shop;




--Revenue Calculation 
--Revenue per transaction

SELECT transaction_id,
       transaction_qty * unit_price AS revenue
FROM casestudy.bright.coffee_shop;


------------------------------------------------------------------------------------------------------
-- Creating Final the table 

SELECT transaction_date,
       DAYNAME(transaction_date) AS day_name,
      
   CASE 
      WHEN day_name IN ('Sat','Sun') THEN 'Weekend'
      ELSE 'Weekday'
   END AS day_classification, 
    MONTHNAME(transaction_date) AS month_name,
    ---transaction_time,
    CASE 
      WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
      WHEN transaction_time BETWEEN '12:00:00' AND '16:59:59' THEN 'Afternoon'
      WHEN transaction_time >= '17:00:00' THEN 'Evening'
    END AS time_classification,
    HOUR(transaction_time) AS hour_of_day,
    store_location,
    product_category,
    product_detail,
    product_type,
    unit_price,
    transaction_qty,
    COUNT(DISTINCT transaction_id) AS number_of_sales,
    SUM(transaction_qty * unit_price) AS Revenue
FROM casestudy.bright.coffee_shop
GROUP BY ALL; 
