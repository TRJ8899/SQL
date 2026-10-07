# Pizza Sales Data Analysis Project

A relational database and SQL analytics project exploring **over 800,000+ in sales revenue** across multiple relational tables. This project uncovers peak customer ordering hours, high-performing menu categories, and top-selling pizza items to optimize restaurant inventory and revenue.

---

# Motivation: How I Came Up With This Idea
I built this project to simulate a real-world business intelligence challenge for a fast-casual restaurant or pizza chain. Instead of just looking at raw sales numbers, I wanted to investigate operational efficiency—specifically answering questions like: *When do customers order the most? Which menu categories drive the highest profit margins? And how can data-driven menu engineering improve daily inventory and staffing decisions?*

---

# Data Sourcing & Extraction
* **Relational Schema:** The project uses a normalized relational database structure consisting of four core tables:
  * `orders`: Tracks order IDs, dates, and timestamps of purchases.
  * `order_details`: Links specific orders to individual pizzas and quantities purchased.
  * `pizzas`: Stores unique pizza IDs, sizes, prices, and foreign keys.
  * `pizza_types`: Categorizes pizzas by name, style, and category (e.g., Classic, Veggie, Supreme, Chicken).
* **Data Extraction & Tools:** The raw CSV datasets were queried and analyzed using **SQL**, extracting complex insights by joining relational tables and aggregating transaction logs.

---

# Methodology & Metric Calculations
To evaluate performance objectively, the following core calculations and SQL queries were implemented:

* **Total Revenue Generation:** 
  $$\text{Total Revenue} = \sum (\text{Quantity Ordered} \times \text{Pizza Price})$$
* **Average Daily Order Volume:** 
  $$\text{Avg Pizzas Per Day} = \text{ROUND}\left(\text{AVG}(\sum \text{Quantity per Date}), 0\right)$$
* **Category Revenue Contribution Percentage:** 
  $$\text{Category Revenue \%} = \left(\frac{\text{Total Revenue of Category}}{\text{Total Overall Revenue}}\right) \times 100$$

---

# Key Insights & Findings

* **Total Business Revenue:** The analysis evaluated a total gross revenue of **$817,860.05** across the dataset lifecycle.
* **Top-Selling Item:** *The Classic Deluxe Pizza* emerged as the highest-volume item, with **2,453 units sold**.
* **Peak Ordering Windows:** Hourly distribution queries revealed sharp surges in order volume during standard lunch and dinner rush hours, highlighting critical windows for staff allocation.
* **Category Dominance:** Revenue contribution breakdowns showed which specific food categories drive the majority of top-line revenue, guiding future menu promotions.

---

# Business Applicability & Scalability
While this project focuses on a pizza restaurant, **this analytical methodology is universally applicable** to any restaurant chain, hospitality business, or multi-location retail store:
* **For Coffee Shops & Cafes:** Swap out pizza sizes and categories for beverage sizes and pastry types to track hourly rush-hour demand.
* **For E-Commerce Retail:** Use this exact relational database pipeline (Orders, Order Details, Products, Categories) to track product category performance and inventory turnover.
By structuring retail data relational models this way, operations teams can instantly diagnose sales trends and optimize staffing or inventory in real-time.

---

# Key SQL Query Example
```sql
-- Calculate the percentage contribution of each pizza category to total revenue
SELECT 
    pizza_types.category, 
    ROUND(SUM(order_details.quantity * pizzas.price) / 
    (SELECT ROUND(SUM(order_details.quantity * pizzas.price), 2) 
     FROM order_details JOIN pizzas ON pizzas.pizza_id = order_details.pizza_id) * 100, 2) AS revenue_percentage
FROM pizza_types 
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category 
ORDER BY revenue_percentage DESC;





