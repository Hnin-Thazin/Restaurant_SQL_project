# Restaurant_SQL_project
My SQL Project (Used MySQL Workbench)

Insights
* Sales data covers 5 months (Jan–May 2023) with 5,000 unique orders and 12,000+ items ordered.
* Italian category has highest avg price at $16.75.
* Hamburger from American category has the highest sales volume while Chicken Taco from Mexican category has least ordered.

**SQL Queries** 

USE restaurant_db;

-- View the menu_items table
SELECT *
FROM menu_items;
----------------------------------------
-- Find the number of items on the menu
SELECT COUNT(*) num_item
FROM menu_items;
-- ** There are 32 items on the menu**
------------------------------------------
-- What are the least and most expensive items on the menu? 
SELECT *
FROM menu_items
ORDER BY price;
-- ** Least expensive item is Edamame and it is within the Asian category**

SELECT *
FROM menu_items
ORDER BY price DESC;
-- ** Most expensive item is Shrimp Scampi and it is within the Italian category**
------------------------------------------
-- How many dishes are in each category? 
SELECT category,COUNT(menu_item_id) num_dish
FROM menu_items
GROUP BY category;
-- ** Maxican and Italian categories has 9 on each that is more dishes than American and Asian which are 6 and 8**
------------------------------------------
-- What is the average dish price within each category? 
SELECT category,AVG(price) avg_price
FROM menu_items
GROUP BY category
ORDER BY avg_price DESC; 
-- ** Italian dishes average price is the most expensive & there are 9 dishes within Italian category**
------------------------------------------
-- What are the least and most expensive Italian dishes on the menu? 
SELECT *
FROM menu_items
WHERE category = 'Italian'
ORDER BY price;
-- ** the least expensive Italian dish is Spaghetti**

SELECT *
FROM menu_items
WHERE category = 'Italian'
ORDER BY price DESC;
-- ** the most expensive Italian dish is Shrimp Scampi**
------------------------------------------

-- What is the date range of the table?
SELECT MIN(order_date), MAX(order_date)
FROM order_details;
-- ** the table has the sales record from 1st Jan 2023 to 31st May 2023, for three months **
------------------------------------

-- How many orders were made within the date range? 
SELECT COUNT(DISTINCT order_id)
FROM order_details;
-- ** there are about 5K orders from Jan to March 2023** 
------------------------------------

-- How many items were ordered within the date range?
SELECT COUNT(*)
FROM order_details;
-- ** there are more than 12K items that are ordered**
------------------------------------

-- Which orders have the most number of items? 
SELECT order_id,COUNT(item_id) num_item
FROM order_details
GROUP BY order_id
ORDER BY num_item desc;
-- ** the order that has the most number of items has 14 items on each order -- 
------------------------------------

-- How many orders have more than 12 items? 
SELECT COUNT(*) as num_of_order
FROM
(SELECT order_id,COUNT(item_id) num_item
FROM order_details
GROUP BY order_id
HAVING num_item > 12) as num_order;
------------------------------------
-- COmbine the menu_items and order_details tables
SELECT *
FROM order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id;
-----------------------------------------

-- What are the least and most ordered items? And which category?
SELECT item_name,category, COUNT(order_details_id) as count_purchase
FROM order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
GROUP BY item_name,category
ORDER BY count_purchase;
-- ** the least ordered item is Chicken Tacos and it is in Mexican category**

SELECT item_name,category, COUNT(order_details_id) as count_purchase
FROM order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
GROUP BY item_name,category
ORDER BY count_purchase DESC;
-- ** the most ordered item is Hamburger and it is in the American category** 
-----------------------------------------

-- What are the top 5 orders that spent the most money?
SELECT order_id,SUM(price) as total_spend
FROM order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
GROUP BY order_id
ORDER BY total_spend desc
LIMIT 5;
-----------------------------------------

-- View the details of the highest spent order. Take insights 

SELECT category, count(item_id)
FROM order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
WHERE  order_id = 440
GROUP BY category;
-- ** Italian dish were order specifically more than the 3 other categories**

-- VIew the details of the top 5 highest spent order, take insights 
SELECT order_id,category, count(item_id) as num_item
FROM order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
WHERE order_id IN (440,2075,1957,330,2675)
GROUP BY order_id,category
ORDER BY order_id,num_item DESC;
-- ** Italian dish is the most ordered cagetory than 3 other categories in the top 5 spend orders**
-----------------------------------------
-- to find the most to least popular dishes by each category 

SELECT item_name,category,COUNT(order_details_id) AS num_purchase,
RANK () OVER(PARTITION BY category ORDER BY COUNT(order_details_id) DESC) as rank_num
FROM order_details od
INNER JOIN menu_items mi
ON od.item_id = mi.menu_item_id
GROUP BY item_name,category;

-- ** Hamburger is the most popular and Veggie Burger is the least popular in American category** --
-- ** Edamame is is the most popular and Potstickers is the least popular in Asian category** -- 
-- ** Spaghetti & Meatballs is is the most popular and Cheese Lasagna is the least popular in Italian category** -- 
-- ** Steak Torta is is the most popular and Chicken Tacos is the least popular in Mexican category** -- 



