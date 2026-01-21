-- Retrieve the total number of orders placed.
select count(order_id) as total_orders from orders;


-- Calculate the total revenue generated from pizza sales.
select 
round(sum(order_details.quantity * pizzas.price),2) as total_revenue
from 
order_details join pizzas
on order_details.pizza_id = pizzas.pizza_id;



-- Identify the highest-priced pizza.
select
pizzas.price, pizza_types.name
from 
pizza_types join pizzas 
on pizzas.pizza_type_id = pizza_types.pizza_type_id
order by pizzas.price desc limit 1;


-- Identify the most common pizza size ordered.
select 
pizzas.size, count(order_details.order_details_id) as largest_size
from 
pizzas join order_details
on pizzas.pizza_id = order_details.pizza_id
group by pizzas.size order by largest_size desc limit 1;



-- List the top 5 most ordered pizza types along with their quantities
select 
pizza_types.name, sum(order_details.quantity) as most_ordered_pizza
from
pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by most_ordered_pizza desc limit 5;




-- total quantity of each pizza category ordered.
select
pizza_types.category, sum(order_details.quantity) as pizza_category
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category order by pizza_category desc;



-- Determine the distribution of orders by hour of the day.
select hour(time_id), count(order_id)
from orders
group by hour(time_id);


-- find the category-wise distribution of pizzas
select 
pizza_types.category,  count(pizza_types.name)
from pizza_types
group by pizza_types.category;


-- Group the orders by date and 
-- calculate the average number of pizzas ordered per day.
select round(avg(adding_quantity),0) from
(select 
orders.date_id, sum(order_details.quantity) as adding_quantity
from orders join order_details
on orders.order_id = order_details.order_id
group by orders.date_id) as order_quantity;



-- Determine the top 3 most ordered pizza types based on revenue.
select
pizza_types.name, sum(order_details.quantity*pizzas.price) as top_three
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by top_three desc limit 3;


-- Calculate the percentage contribution of each pizza type to total revenue.
select pizza_types.category, 
round(sum( order_details.quantity*pizzas.price) 
/ (select
round(sum(order_details.quantity * pizzas.price), 2) as total_sales
from order_details join pizzas
on pizzas.pizza_id = order_details.pizza_id)*100,2) as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category order by revenue desc;
