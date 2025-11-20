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


