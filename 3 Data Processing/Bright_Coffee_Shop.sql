-- Databricks notebook source
-----------Checking the data
SELECT*
FROM brightcoffe.brightcoff.`1782394740697_bright_coffee_shop_sales_3`
LIMIT 100;

------CHECKING FOR NULL
SELECT *
FROM brightcoffe.brightcoff.`1782394740697_bright_coffee_shop_sales_3`
WHERE transaction_id IS NULL
OR transaction_date IS NULL
OR transaction_time IS NULL
OR transaction_qty IS NULL
OR store_id IS NULL
OR store_location IS NULL
OR product_id IS NULL
OR unit_price IS NULL
OR product_category IS NULL
OR product_type IS NULL
OR product_detail IS NULL;

------------------Cecking for dulipacate in my data
SELECT transaction_id,
COUNT(*) AS duplicate_count
FROM brightcoffe.brightcoff.`1782394740697_bright_coffee_shop_sales_3`
GROUP BY transaction_id
HAVING COUNT(*) > 1;

------------------Checking for the unique product categorg
SELECT DISTINCT  product_category
FROM brightcoffe.brightcoff.`1782394740697_bright_coffee_shop_sales_3`;

----------------CHECKING FOR Distinct store_location
SELECT DISTINCT store_location
FROM brightcoffe.brightcoff.`1782394740697_bright_coffee_shop_sales_3`;
------------------------------CHECKING FOR DISTINCT product_type
SELECT DISTINCT product_type
FROM brightcoffe.brightcoff.`1782394740697_bright_coffee_shop_sales_3`;
------------------------------Converting transaction_date into datefunction
SELECT
transaction_date,
TO_DATE(transaction_date) AS transaction_date,
DAYNAME(TO_DATE(transaction_date)) AS DAY_name,
MONTHNAME(TO_DATE(transaction_date)) AS Month_name,
YEAR(TO_DATE(transaction_date)) AS Sales_Year,
DAY(TO_DATE(transaction_date)) AS day_year
FROM brightcoffe.brightcoff.`1782394740697_bright_coffee_shop_sales_3`;
---------------------transaction_date
SELECT
DATE_FORMAT(transaction_time, 'HH:mm:ss') AS transaction_time
FROM brightcoffe.brightcoff.`1782394740697_bright_coffee_shop_sales_3`;

SELECT
CASE
WHEN HOUR(transaction_time) BETWEEN 0 AND 5 THEN ' Midnight'
WHEN HOUR(transaction_time) BETWEEN 6 AND 11 THEN 'Morning'
WHEN HOUR(transaction_time) BETWEEN 12 AND 16 THEN 'Afternoon'
WHEN HOUR(transaction_time) BETWEEN 17 AND 23 THEN 'Evening'
END AS transaction_Period
FROM brightcoffe.brightcoff.`1782394740697_bright_coffee_shop_sales_3`;
--------------add the total sale 
SELECT transaction_id,
store_location,
transaction_qty,
unit_price,
transaction_qty*unit_price AS Total_sale
FROM brightcoffe.brightcoff.`1782394740697_bright_coffee_shop_sales_3`;
-----------------------creating a temp table
CREATE OR REPLACE TEMP VIEW coffee_sales_temp AS
SELECT
transaction_id,
TO_DATE(transaction_date) AS transaction_date,
DAYNAME(TO_DATE(transaction_date)) AS day_name,
MONTHNAME(TO_DATE(transaction_date)) AS month_name,
YEAR(TO_DATE(transaction_date)) AS sales_year,
DAY(TO_DATE(transaction_date)) AS day_of_month,
DATE_FORMAT(transaction_time, 'HH:mm:ss') AS transaction_time,
CASE
WHEN HOUR(transaction_time) BETWEEN 0 AND 5 THEN 'Midnight'
WHEN HOUR(transaction_time) BETWEEN 6 AND 11 THEN 'Morning'
WHEN HOUR(transaction_time) BETWEEN 12 AND 16 THEN 'Afternoon'
WHEN HOUR(transaction_time) BETWEEN 17 AND 23 THEN 'Evening'
END AS transaction_period,
transaction_qty,
ROUND(unit_price,2)AS Unit_price,
ROUND(transaction_qty * unit_price ,2 )AS total_sale,
store_id,
store_location,product_id,
product_category,
product_type,
product_detail
FROM brightcoffe.brightcoff.`1782394740697_bright_coffee_shop_sales_3`;

SELECT*
FROM coffee_sales_temp