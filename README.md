# Restaurant Order Analysis SQL

![heading](https://github.com/user-attachments/assets/ad0114d3-d2ad-4811-a5a1-cc581c0a3ca3)

This project is a structured SQL-based analysis of restaurant orders, aimed at deriving key insights from transactional data. 

# Project Brief
![objective](https://github.com/user-attachments/assets/2e833091-9d0b-4570-9385-d56e7cbaa925)

![objective_1](https://github.com/user-attachments/assets/602843d5-68c0-4f49-a5ab-c3337791de73)

![objective_2](https://github.com/user-attachments/assets/760f6224-c5e8-4c8e-8444-df6aaf3239ba)

![objective_3](https://github.com/user-attachments/assets/9050c831-7866-4abc-961b-95f87fc8c027)

## Database Schema  

The project includes two tables:  

![image](https://github.com/user-attachments/assets/68306a80-3f64-4ac6-ba3d-705db9bc7c88)

# SQL Solutions
The SQL scripts in this repository cover:

Data Exploration: Understanding the structure and key statistics.

Revenue Analysis: Identifying top-selling and most profitable items.

Order Trends: Analyzing peak ordering times and customer preferences.

Performance Insights: Evaluating order frequency and restaurant efficiency.

### -> View the menu_items table and write a query to find the number of items on the menu
```sql
select * from menu_items;
select count(*) from menu_items;
```
### -> What are the price of least and most expensive items on the menu?
```sql
select min(price) from menu_items;
select max(price) from menu_items;
```
### -> How many Italian dishes are on the menu?
```sql
select count(*) from menu_items 
where category = 'Italian';
```
### -> What are the least and most expensive Italian dishes on the menu? Sort the table.
```sql
select * from menu_items 
where category = 'Italian'
order by price;

select * from menu_items 
where category = 'Italian'
order by price desc;
```
### ->  What are the items on the menu that have chicken in them.
```sql
select * from menu_items 
where item_name like '%Chicken%';
```
### -> How many dishes are in each category?
```sql
select category , count(*) 
from menu_items
group by 1;
```
### -> What is the average dish price within each category?
```sql
select category , avg(price) as avg_price
from menu_items
group by category;
```

### -> View the order_details table.
```sql
select * from order_details;
```
### -> What is the date range of the table?
```sql
SELECT min(order_date) , max(order_date)
from order_details;
```
### -> How many orders were made within this date range?
```sql
SELECT count(distinct order_id) 
from order_details;
```
### ->  How many items were ordered within this date range?
```sql
SELECT count(item_id) 
from order_details;
```
### -> Which orders had the most number of items?
```sql
select order_id , count(item_id) as item_count
from order_details
GROUP by order_id 
order by item_count desc;
```
### -> How many orders had more than 12 items?
```sql
select count(*) from  
(select order_id , count(item_id) as item_count
from order_details
GROUP by order_id 
HAVING count(item_id) > 12)  as num_orders;
```
### -> Combine the menu_items and order_details tables into a single table
```sql
select * from order_details 
left join menu_items on order_details.item_id = menu_items.menu_item_id;
```

### -> What were the least and most ordered items? What categories were they in?
```sql
select category , item_name , count(item_id) from order_details 
left join menu_items on order_details.item_id = menu_items.menu_item_id
GROUP by 1,2
order by 3 desc ;
```
### -> What were the top 5 orders that spent the most money?
```sql
select order_id , sum(price)
from order_details 
left join menu_items on order_details.item_id = menu_items.menu_item_id
where price is not null
group by 1
order by 2 DESC
limit 5; 
```
### -> View the details of the highest spend order. Which specific items were purchased?
```sql
select order_id , item_name, sum(price)
from order_details 
left join menu_items on order_details.item_id = menu_items.menu_item_id
where price is not null
group by 1 ,2
order by 3 DESC
limit 1; 
```
### ->  how many categories have max price below 15$
###  solved using SUBQUERY
```sql
select count(*) from
(
select category ,  max(price)  
from menu_items
group by 1
having max(price) < 15) as categories_having_max_price;
```
###  solved using CTE.
```sql
with categories_having_max_price as (select category ,  max(price)  
from menu_items
group by 1
having max(price) < 15)

select count(*) from categories_having_max_price;
```


