
select * from pizza_sales

-- KPIs

-- Total_Revenue
select sum(total_price) as Total_Revenue from pizza_sales


-- Avereage_Revenue_Order
select sum(total_price)/count(distinct order_id) as average_order_value from pizza_sales


-- Total_Pizza_Sold
select sum(quantity) as Total_orders from pizza_sales


-- Total_Orders
select count(distinct order_id) as Total_Orders from pizza_sales


--Average_Pizza_sold_per_order
select cast(cast(sum(quantity) as decimal(10,2))/cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2))
as Average_Pizza_Sold_Per_Order from pizza_sales

--Chart Requirements

--Daily Trend for Total Orders
select datename(dw,order_date) as order_day, count(distinct order_id) as no_of_orders from pizza_sales group by datename(dw,order_date)

--monthly Trend for Total orders
select datename(month,order_date) as month_name, count(distinct order_id) as no_of_orders from pizza_sales 
group by datename(month,order_date)
order by no_of_orders desc


--Percentage of sales by pizza category for january month
  SELECT pizza_category, sum(total_price) as total_price , count(distinct order_id) as no_of_orders,
  SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) = 1) as pct
  FROM pizza_sales 
  WHERE MONTH(order_date) = 1
  GROUP BY pizza_category
 

 --Percentage of sales by pizza size for quarter
 select pizza_size, cast(sum(total_price) as decimal(10,2))as total_price, 
 cast(sum(total_price)  * 100 / 
 (select sum(total_price)  from pizza_sales where datepart(quarter, order_date)=1) 
 as decimal(10,2)) as pct
 from pizza_sales 
 where datepart(quarter, order_date) =1
 group by pizza_size
 order by pct desc



 --Total Pizzas Sold by Pizza Category
 select pizza_size , count(distinct order_id) as no_of_orders, sum(quantity) as no_of_pizzas_sold from 
 pizza_sales 
 group by pizza_size



 
 --Top 5 Best Sellers By Revenue, Total Quantity and Total orders
 select Top 5pizza_name , sum(total_price) as Total_Revenue , sum(quantity) as Total_Quantity,
 count(distinct order_id) as Total_Orders from pizza_sales
 group by pizza_name
 order by Total_Revenue DESC, Total_Quantity Desc ,Total_Orders DESC 
 