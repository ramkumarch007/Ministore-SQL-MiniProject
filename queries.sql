-- ============================================
-- MiniStoreDB 
-- Note:
-- Some queries use stored Total_Spent for simplicity.
-- Analytical queries calculate revenue dynamically from orders.
-- ============================================


-- Level 1 – Basics & Filtering

-- 1. List all customers who have spent more than 10,000.
SELECT *
FROM customers 
WHERE Total_Spent > 10000;

-- 2. Retrieve all products in the “Furniture” category.
SELECT *
FROM products
WHERE Category = 'Furniture';

-- 3. Show all orders placed in 2025.
SELECT *
FROM orders
WHERE Order_Date BETWEEN '2025-01-01' AND '2025-12-31';

-- 4. Find products with a rating greater than 4.
SELECT *
FROM products
WHERE Rating > 4;


-- Level 2 – Aggregation & Grouping

-- 5. Calculate total revenue per product.
SELECT 
    p.product_name,
    SUM(o.quantity * p.price) AS total_revenue
FROM products p
JOIN order_items o
    ON p.product_id = o.product_id
GROUP BY p.product_name;

-- 6. Find the number of orders per customer.
SELECT 
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS no_of_orders
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

-- 7. Find the highest-spending customer.
SELECT 
    name,
    Total_Spent AS highest_spending
FROM customers
ORDER BY Total_Spent DESC
LIMIT 1;

-- 8. Find average quantity sold per product.
SELECT 
    p.product_name,
    ROUND(AVG(o.quantity), 2) AS avg_quantity_sold
FROM products p
JOIN order_items o 
    ON p.product_id = o.product_id
GROUP BY p.product_name;


-- Level 3 – Joins

-- 9. Show order details including customer name, product name, and quantity.
SELECT 
    c.name,
    p.product_name,
    o.quantity
FROM products p
JOIN order_items o 
    ON p.product_id = o.product_id
JOIN orders ord
    ON o.order_id = ord.order_id
JOIN customers c
    ON ord.customer_id = c.customer_id;

-- 10. Find total revenue per customer using JOIN.
SELECT 
    c.customer_id,
    c.name,
    SUM(o.total_amount - o.discount) AS total_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

-- 11. List products never ordered.
SELECT 
    p.product_id,
    p.product_name
FROM products p
LEFT JOIN order_items o
    ON p.product_id = o.product_id
WHERE o.product_id IS NULL;

-- 12. Find customers who ordered products from "DellStore".
SELECT DISTINCT
    c.customer_id,
    c.name,
    p.supplier
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
WHERE LOWER(p.supplier) = 'dellstore';


-- Level 4 – WHERE, HAVING & CASE

-- 13. List orders with total amount > 5000.
SELECT 
    order_id,
    total_amount
FROM orders
WHERE total_amount > 5000;

-- 14. Show total revenue per product category having revenue > 10,000.
SELECT
    p.category,
    SUM(o.quantity * p.price) AS total_revenue
FROM products p
JOIN order_items o
    ON p.product_id = o.product_id
GROUP BY p.category
HAVING SUM(o.quantity * p.price) > 10000;

-- 15. Categorize customers as 'High Spender' (>10000) or 'Low Spender'.
SELECT 
    customer_id,
    name,
    Total_Spent,
    CASE 
        WHEN Total_Spent > 10000 THEN 'High Spender'
        ELSE 'Low Spender'
    END AS spender_category
FROM customers;


-- Level 5 – Advanced Joins & Sorting

-- 16. Rank products by total quantity sold.
SELECT 
    p.product_name,
    SUM(o.quantity) AS total_qty_sold,
    RANK() OVER (ORDER BY SUM(o.quantity) DESC) AS product_rank
FROM products p
JOIN order_items o
    ON p.product_id = o.product_id
GROUP BY p.product_name;

-- 17. List top 5 customers based on total spending.
SELECT 
    customer_id,
    name,
    Total_Spent
FROM customers
ORDER BY Total_Spent DESC
LIMIT 5;

-- 18. Find the most popular category (highest quantity sold).
SELECT 
    p.category,
    SUM(o.quantity) AS total_quantity
FROM products p
JOIN order_items o
    ON p.product_id = o.product_id
GROUP BY p.category
ORDER BY total_quantity DESC
LIMIT 1;

-- 19. Identify products below reorder level.
-- Note: Reorder logic approximated using sales quantity
SELECT 
    p.product_name,
    SUM(o.quantity) AS total_quantity_sold,
    p.reorder_level
FROM products p
JOIN order_items o
    ON p.product_id = o.product_id
GROUP BY p.product_name, p.reorder_level
HAVING SUM(o.quantity) <= p.reorder_level;

-- 20. Find employees who handled the most orders.
SELECT 
    employee_id,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY employee_id
ORDER BY total_orders DESC
LIMIT 1;
