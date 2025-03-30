select * from order_details;
select * from menu_items;

--View the menu_items table and write a query to find the number of items on the menu
select * from menu_items;
select count(*) from menu_items;

--What are the price of least and most expensive items on the menu?
select min(price) from menu_items;
select max(price) from menu_items;

--How many Italian dishes are on the menu? 
select count(*) from menu_items 
where category = 'Italian';

-- What are the least and most expensive Italian dishes on the menu?
select * from menu_items 
where category = 'Italian'
order by price;

select * from menu_items 
where category = 'Italian'
order by price desc;

-- What are the items on the menu that have chicken in them.
select * from menu_items 
where item_name like '%Chicken%';

--How many dishes are in each category? 
select category , count(*) 
from menu_items
group by 1;

--What is the average dish price within each category?
select category , avg(price) as avg_price
from menu_items
group by category;


--View the order_details table. 
select * from order_details;

--What is the date range of the table?
SELECT min(order_date) , max(order_date)
from order_details;

--How many orders were made within this date range? 
SELECT count(distinct order_id) 
from order_details;

-- How many items were ordered within this date range?
SELECT count(item_id) 
from order_details;

--Which orders had the most number of items?
select order_id , count(item_id) as item_count
from order_details
GROUP by order_id 
order by item_count desc;

--How many orders had more than 12 items?
select count(*) from  
(select order_id , count(item_id) as item_count
from order_details
GROUP by order_id 
HAVING count(item_id) > 12)  as num_orders;

--Combine the menu_items and order_details tables into a single table
select * from order_details 
left join menu_items on order_details.item_id = menu_items.menu_item_id;


--What were the least and most ordered items? What categories were they in?
select category , item_name , count(item_id) from order_details 
left join menu_items on order_details.item_id = menu_items.menu_item_id
GROUP by 1,2
order by 3 desc ;

--What were the top 5 orders that spent the most money?
select order_id , sum(price)
from order_details 
left join menu_items on order_details.item_id = menu_items.menu_item_id
where price is not null
group by 1
order by 2 DESC
limit 5; 

--View the details of the highest spend order. Which specific items were purchased?
select order_id , item_name, sum(price)
from order_details 
left join menu_items on order_details.item_id = menu_items.menu_item_id
where price is not null
group by 1 ,2
order by 3 DESC
limit 1; 

-- how many categories have max price below 15$
-- solved using SUBQUERY
select count(*) from
(
select category ,  max(price)  
from menu_items
group by 1
having max(price) < 15) as categories_having_max_price;

-- solved using CTE. 
with categories_having_max_price as (select category ,  max(price)  
from menu_items
group by 1
having max(price) < 15)

select count(*) from categories_having_max_price;

