USE restaurant_db;

-- View the order_details table
SELECT *
FROM order_details;
------------------------------------
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