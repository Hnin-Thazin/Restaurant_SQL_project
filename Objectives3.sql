-- Analyze Customer behaviour

SELECT *
FROM menu_items;

SELECT *
FROM order_details;

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





