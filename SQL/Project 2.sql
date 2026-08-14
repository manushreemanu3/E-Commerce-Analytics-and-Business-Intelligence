CREATE DATABASE retail_analytics_project;

USE retail_analytics_project;
SHOW DATABASES;
USE retail_analytics_project;
SELECT DATABASE();

SELECT COUNT(*) AS customer_count
FROM customers;
SELECT *
FROM customers
LIMIT 5;

SELECT COUNT(*) AS category_count
FROM categories;

SELECT *
FROM categories
LIMIT 5;

SHOW TABLES;

SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL
SELECT 'categories', COUNT(*) FROM categories
UNION ALL
SELECT 'employees', COUNT(*) FROM employees
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'payments', COUNT(*) FROM payments
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'promotions', COUNT(*) FROM promotions
UNION ALL
SELECT 'returns', COUNT(*) FROM returns
UNION ALL
SELECT 'shipments', COUNT(*) FROM shipments
UNION ALL
SELECT 'stores', COUNT(*) FROM stores
UNION ALL
SELECT 'suppliers', COUNT(*) FROM suppliers;


SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'retail_analytics_project'
ORDER BY TABLE_NAME, ORDINAL_POSITION;

SELECT 
    COUNT(*) AS total_customers,
    COUNT(DISTINCT customer_id) AS unique_customer_ids
FROM customers;

SELECT 
    COUNT(*) AS total_orders,
    COUNT(DISTINCT order_id) AS unique_order_ids
FROM orders;

SELECT 
    COUNT(*) AS total_order_items,
    COUNT(DISTINCT order_item_id) AS unique_order_item_ids
FROM order_items;

SELECT 
    COUNT(*) AS total_products,
    COUNT(DISTINCT product_id) AS unique_product_ids
FROM products;

SELECT 
    COUNT(*) AS total_categories,
    COUNT(DISTINCT category_id) AS unique_category_ids
FROM categories;

SELECT 
    COUNT(*) AS total_stores,
    COUNT(DISTINCT store_id) AS unique_store_ids
FROM stores;


SELECT 
    COUNT(*) AS total_suppliers,
    COUNT(DISTINCT supplier_id) AS unique_supplier_ids
FROM suppliers;

SELECT 
    COUNT(*) AS total_employees,
    COUNT(DISTINCT employee_id) AS unique_employee_ids
FROM employees;

SELECT 
    COUNT(*) AS total_payments,
    COUNT(DISTINCT payment_id) AS unique_payment_ids
FROM payments;

SELECT 
    COUNT(*) AS total_promotions,
    COUNT(DISTINCT promotion_id) AS unique_promotion_ids
FROM promotions;

SELECT 
    COUNT(*) AS total_returns,
    COUNT(DISTINCT return_id) AS unique_return_ids
FROM returns;

SELECT 
    COUNT(*) AS total_shipments,
    COUNT(DISTINCT shipment_id) AS unique_shipment_ids
FROM shipments;

SELECT 
    signup_date
FROM customers
LIMIT 10;

SELECT 
    order_date
FROM orders
LIMIT 10;

ALTER TABLE customers
MODIFY signup_date DATE;

ALTER TABLE orders
MODIFY order_date DATE;

DESCRIBE customers;
DESCRIBE orders;

SELECT
    SUM(customer_id IS NULL) AS null_customer_id,
    SUM(store_id IS NULL) AS null_store_id,
    SUM(order_date IS NULL) AS null_order_date,
    SUM(promotion_id IS NULL) AS null_promotion_id
FROM orders;

SELECT
    SUM(order_id IS NULL) AS null_order_id,
    SUM(product_id IS NULL) AS null_product_id,
    SUM(qty IS NULL) AS null_qty,
    SUM(price IS NULL) AS null_price
FROM order_items;

SELECT
    SUM(order_id IS NULL) AS null_order_id,
    SUM(amount IS NULL) AS null_amount
FROM payments;

SELECT
    SUM(category_id IS NULL) AS null_category_id,
    SUM(supplier_id IS NULL) AS null_supplier_id,
    SUM(price IS NULL) AS null_price
FROM products;

SELECT
    SUM(order_item_id IS NULL) AS null_order_item_id,
    SUM(refund IS NULL) AS null_refund
FROM returns;

SELECT
    SUM(order_id IS NULL) AS null_order_id,
    SUM(status IS NULL) AS null_status
FROM shipments;

SELECT
    SUM(city IS NULL) AS null_city,
    SUM(signup_date IS NULL) AS null_signup_date
FROM customers;

SELECT
    SUM(category_name IS NULL) AS null_category_name
FROM categories;

SELECT
    SUM(city IS NULL) AS null_store_city
FROM stores;

SELECT
    SUM(store_id IS NULL) AS null_store_id,
    SUM(salary IS NULL) AS null_salary
FROM employees;

SELECT
    SUM(country IS NULL) AS null_country
FROM suppliers;

SELECT
    SUM(discount IS NULL) AS null_discount
FROM promotions;

SELECT
    MIN(qty) AS min_qty,
    MIN(price) AS min_price
FROM order_items;

SELECT
    MIN(amount) AS min_payment,
    MAX(amount) AS max_payment
FROM payments;

SELECT
    MIN(price) AS min_price,
    MAX(price) AS max_price
FROM products;

SELECT
    MIN(discount) AS min_discount,
    MAX(discount) AS max_discount
FROM promotions;

SELECT
    MIN(refund) AS min_refund,
    MAX(refund) AS max_refund
FROM returns;

SELECT
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary
FROM employees;

SELECT
    AVG(salary) AS avg_salary,
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary
FROM employees;

SELECT
    status,
    COUNT(*) AS shipment_count
FROM shipments
GROUP BY status
ORDER BY shipment_count DESC;

SELECT
    COUNT(*) AS total_orders,
    COUNT(promotion_id) AS orders_with_promotion,
    COUNT(*) - COUNT(promotion_id) AS orders_without_promotion
FROM orders;

SELECT COUNT(*) AS unmatched_orders
FROM orders o
LEFT JOIN customers c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT COUNT(*) AS unmatched_orders
FROM orders o
LEFT JOIN stores s
    ON o.store_id = s.store_id
WHERE s.store_id IS NULL;

SELECT COUNT(*) AS unmatched_orders
FROM orders o
LEFT JOIN promotions p
    ON o.promotion_id = p.promotion_id
WHERE p.promotion_id IS NULL;

SELECT COUNT(*) AS unmatched_order_items
FROM order_items oi
LEFT JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

SELECT COUNT(*) AS unmatched_order_items
FROM order_items oi
LEFT JOIN products p
    ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

SELECT COUNT(*) AS unmatched_products
FROM products p
LEFT JOIN categories c
    ON p.category_id = c.category_id
WHERE c.category_id IS NULL;

SELECT COUNT(*) AS unmatched_products
FROM products p
LEFT JOIN suppliers s
    ON p.supplier_id = s.supplier_id
WHERE s.supplier_id IS NULL;

SELECT COUNT(*) AS unmatched_employees
FROM employees e
LEFT JOIN stores s
    ON e.store_id = s.store_id
WHERE s.store_id IS NULL;

SELECT COUNT(*) AS unmatched_payments
FROM payments p
LEFT JOIN orders o
    ON p.order_id = o.order_id
WHERE o.order_id IS NULL;

SELECT COUNT(*) AS unmatched_returns
FROM returns r
LEFT JOIN order_items oi
    ON r.order_item_id = oi.order_item_id
WHERE oi.order_item_id IS NULL;

SELECT COUNT(*) AS unmatched_shipments
FROM shipments s
LEFT JOIN orders o
    ON s.order_id = o.order_id
WHERE o.order_id IS NULL;

SELECT
    COUNT(*) AS orders_with_multiple_payments
FROM (
    SELECT order_id
    FROM payments
    GROUP BY order_id
    HAVING COUNT(*) > 1
) AS payment_check;

SELECT COUNT(*) AS orders_without_shipment
FROM orders o
LEFT JOIN shipments s
    ON o.order_id = s.order_id
WHERE s.order_id IS NULL;

SELECT COUNT(*) AS orders_without_payment
FROM orders o
LEFT JOIN payments p
    ON o.order_id = p.order_id
WHERE p.order_id IS NULL;

SELECT COUNT(*) AS orders_without_items
FROM orders o
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE oi.order_id IS NULL;

SELECT
    COUNT(*) AS total_orders,
    COUNT(*) - 40767 AS orders_with_items,
    40767 AS orders_without_items,
    ROUND(40767 * 100.0 / COUNT(*), 2) AS percentage_without_items
FROM orders;

SELECT
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date
FROM orders o
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE oi.order_id IS NULL;

SELECT
    YEAR(o.order_date) AS order_year,
    COUNT(*) AS orders_without_items
FROM orders o
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE oi.order_id IS NULL
GROUP BY YEAR(o.order_date)
ORDER BY order_year;

SELECT
    COUNT(*) AS missing_item_orders,
    SUM(p.amount) AS total_payment_amount
FROM orders o
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN payments p
    ON o.order_id = p.order_id
WHERE oi.order_id IS NULL;

SELECT
    ROUND(AVG(p.amount), 2) AS avg_payment_missing_items,
    MIN(p.amount) AS min_payment,
    MAX(p.amount) AS max_payment
FROM orders o
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN payments p
    ON o.order_id = p.order_id
WHERE oi.order_id IS NULL;

SELECT
    ROUND(AVG(p.amount), 2) AS avg_payment_with_items,
    MIN(p.amount) AS min_payment,
    MAX(p.amount) AS max_payment
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN payments p
    ON o.order_id = p.order_id;

SELECT
    COUNT(DISTINCT o.customer_id) AS customers_with_missing_item_orders
FROM orders o
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE oi.order_id IS NULL;

SELECT
    o.store_id,
    COUNT(*) AS orders_without_items
FROM orders o
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE oi.order_id IS NULL
GROUP BY o.store_id
ORDER BY orders_without_items DESC;

SELECT
    COUNT(*) AS total_orders,
    COUNT(DISTINCT customer_id) AS unique_customers,
    COUNT(DISTINCT store_id) AS active_stores,
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date
FROM orders;

SELECT
    COUNT(*) AS customers_without_orders
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;

SELECT
    COUNT(*) AS total_customers,
    COUNT(o.customer_id) AS customers_with_orders,
    ROUND(COUNT(o.customer_id) * 100.0 / COUNT(*), 2) AS customer_conversion_rate
FROM customers c
LEFT JOIN (
    SELECT DISTINCT customer_id
    FROM orders
) o
    ON c.customer_id = o.customer_id;

SELECT
    YEAR(order_date) AS order_year,
    COUNT(*) AS total_orders,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM orders
GROUP BY YEAR(order_date)
ORDER BY order_year;

SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    COUNT(*) AS total_orders,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY order_year, order_month;

SELECT
    MONTH(order_date) AS order_month,
    COUNT(*) AS total_orders,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM orders
WHERE order_date < '2024-01-01'
GROUP BY MONTH(order_date)
ORDER BY total_orders DESC;

SELECT
    SUM(qty * price) AS total_revenue,
    AVG(qty * price) AS avg_order_item_value
FROM order_items;

SELECT
    YEAR(o.order_date) AS order_year,
    SUM(oi.qty * oi.price) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS orders_with_items
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_date < '2024-01-01'
GROUP BY YEAR(o.order_date)
ORDER BY order_year;

SELECT
    c.category_name,
    SUM(oi.qty * oi.price) AS total_revenue,
    SUM(oi.qty) AS units_sold
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN categories c
    ON p.category_id = c.category_id
GROUP BY c.category_id, c.category_name
ORDER BY total_revenue DESC;

SELECT
    p.product_id,
    p.category_id,
    SUM(oi.qty * oi.price) AS total_revenue,
    SUM(oi.qty) AS units_sold
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_id, p.category_id
ORDER BY total_revenue DESC
LIMIT 10;

SELECT
    p.product_id,
    p.category_id,
    SUM(oi.qty) AS units_sold,
    SUM(oi.qty * oi.price) AS total_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_id, p.category_id
ORDER BY units_sold DESC
LIMIT 10;

SELECT
    o.store_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.qty * oi.price) AS total_revenue,
    SUM(oi.qty) AS units_sold
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.store_id
ORDER BY total_revenue DESC
LIMIT 10;

SELECT
    o.store_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.qty * oi.price) AS total_revenue,
    ROUND(
        SUM(oi.qty * oi.price) / COUNT(DISTINCT o.order_id),
        2
    ) AS revenue_per_order
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.store_id
ORDER BY revenue_per_order DESC
LIMIT 10;

SELECT
    o.customer_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.qty * oi.price) AS total_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.customer_id
ORDER BY total_revenue DESC
LIMIT 10;

SELECT
    total_orders,
    COUNT(*) AS customer_count
FROM (
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS total_orders
    FROM orders
    GROUP BY customer_id
) AS customer_orders
GROUP BY total_orders
ORDER BY total_orders;


SELECT
    CASE
        WHEN total_orders = 1 THEN 'One-time'
        WHEN total_orders BETWEEN 2 AND 4 THEN 'Low-frequency'
        WHEN total_orders BETWEEN 5 AND 9 THEN 'Regular'
        ELSE 'High-frequency'
    END AS customer_segment,
    COUNT(*) AS customer_count
FROM (
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS total_orders
    FROM orders
    GROUP BY customer_id
) AS customer_orders
GROUP BY customer_segment
ORDER BY customer_count DESC;


SELECT
    CASE
        WHEN total_orders = 1 THEN 'One-time'
        WHEN total_orders BETWEEN 2 AND 4 THEN 'Low-frequency'
        WHEN total_orders BETWEEN 5 AND 9 THEN 'Regular'
        ELSE 'High-frequency'
    END AS customer_segment,
    COUNT(DISTINCT customer_id) AS customer_count,
    SUM(total_revenue) AS total_revenue
FROM (
    SELECT
        o.customer_id,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(oi.qty * oi.price) AS total_revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY o.customer_id
) AS customer_data
GROUP BY customer_segment
ORDER BY total_revenue DESC;

SELECT
    p.discount,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.qty * oi.price) AS total_revenue,
    SUM(oi.qty) AS units_sold
FROM promotions p
JOIN orders o
    ON p.promotion_id = o.promotion_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY p.discount
ORDER BY p.discount;

SELECT
    p.discount,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.qty * oi.price) AS total_revenue,
    ROUND(
        SUM(oi.qty * oi.price) / COUNT(DISTINCT o.order_id),
        2
    ) AS revenue_per_order
FROM promotions p
JOIN orders o
    ON p.promotion_id = o.promotion_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY p.promotion_id, p.discount
ORDER BY revenue_per_order DESC;

SELECT
    p.discount,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.qty * oi.price) AS total_revenue,
    ROUND(
        SUM(oi.qty * oi.price) / COUNT(DISTINCT o.order_id),
        2
    ) AS revenue_per_order
FROM promotions p
JOIN orders o
    ON p.promotion_id = o.promotion_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY p.discount
ORDER BY revenue_per_order DESC;

SELECT
    COUNT(*) AS total_returns,
    SUM(refund) AS total_refund,
    ROUND(AVG(refund), 2) AS avg_refund
FROM returns;

SELECT
    COUNT(DISTINCT r.return_id) AS total_returns,
    COUNT(DISTINCT oi.order_item_id) AS total_order_items,
    ROUND(
        COUNT(DISTINCT r.return_id) * 100.0
        / COUNT(DISTINCT oi.order_item_id),
        2
    ) AS return_rate
FROM order_items oi
LEFT JOIN returns r
    ON oi.order_item_id = r.order_item_id;
    
    SELECT
    YEAR(o.order_date) AS order_year,
    COUNT(DISTINCT r.return_id) AS total_returns,
    SUM(r.refund) AS total_refund
FROM returns r
JOIN order_items oi
    ON r.order_item_id = oi.order_item_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_date < '2024-01-01'
GROUP BY YEAR(o.order_date)
ORDER BY order_year;
    
    SELECT
    c.category_name,
    COUNT(DISTINCT r.return_id) AS total_returns,
    COUNT(DISTINCT oi.order_item_id) AS total_items,
    ROUND(
        COUNT(DISTINCT r.return_id) * 100.0
        / COUNT(DISTINCT oi.order_item_id),
        2
    ) AS return_rate
FROM categories c
JOIN products p
    ON c.category_id = p.category_id
JOIN order_items oi
    ON p.product_id = oi.product_id
LEFT JOIN returns r
    ON oi.order_item_id = r.order_item_id
GROUP BY c.category_id, c.category_name
ORDER BY return_rate DESC;

SELECT
    status,
    COUNT(*) AS shipment_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM shipments), 2) AS percentage
FROM shipments
GROUP BY status
ORDER BY shipment_count DESC;

SELECT
    YEAR(o.order_date) AS order_year,
    s.status,
    COUNT(*) AS shipment_count,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (PARTITION BY YEAR(o.order_date)),
        2
    ) AS percentage
FROM shipments s
JOIN orders o
    ON s.order_id = o.order_id
WHERE o.order_date < '2024-01-01'
GROUP BY YEAR(o.order_date), s.status
ORDER BY order_year, shipment_count DESC;

SELECT
    s.supplier_id,
    s.country,
    COUNT(DISTINCT p.product_id) AS products_supplied,
    SUM(oi.qty * oi.price) AS total_revenue,
    SUM(oi.qty) AS units_sold
FROM suppliers s
JOIN products p
    ON s.supplier_id = p.supplier_id
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY s.supplier_id, s.country
ORDER BY total_revenue DESC
LIMIT 10;

SELECT
    c.city,
    COUNT(DISTINCT c.customer_id) AS customers,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.qty * oi.price) AS total_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.city
ORDER BY total_revenue DESC
LIMIT 10;

SELECT
    c.city,
    COUNT(DISTINCT c.customer_id) AS customers,
    SUM(oi.qty * oi.price) AS total_revenue,
    ROUND(
        SUM(oi.qty * oi.price) / COUNT(DISTINCT c.customer_id),
        2
    ) AS revenue_per_customer
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.city
ORDER BY revenue_per_customer DESC;

SELECT
    e.store_id,
    COUNT(DISTINCT e.employee_id) AS employee_count,
    SUM(oi.qty * oi.price) AS total_revenue
FROM employees e
JOIN orders o
    ON e.store_id = o.store_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY e.store_id
ORDER BY total_revenue DESC
LIMIT 10;

SELECT
    e.store_id,
    COUNT(DISTINCT e.employee_id) AS employee_count,
    SUM(oi.qty * oi.price) AS total_revenue,
    ROUND(
        SUM(oi.qty * oi.price) / COUNT(DISTINCT e.employee_id),
        2
    ) AS revenue_per_employee
FROM employees e
JOIN orders o
    ON e.store_id = o.store_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY e.store_id
HAVING COUNT(DISTINCT e.employee_id) > 0
ORDER BY revenue_per_employee DESC
LIMIT 10;

SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS total_customers,
    COUNT(DISTINCT oi.product_id) AS unique_products_sold,
    SUM(oi.qty) AS total_units_sold,
    SUM(oi.qty * oi.price) AS total_revenue,
    ROUND(
        SUM(oi.qty * oi.price) / COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_date < '2024-01-01';


WITH store_revenue AS (
    SELECT
        o.store_id,
        SUM(oi.qty * oi.price) AS total_revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY o.store_id
),
store_employees AS (
    SELECT
        store_id,
        COUNT(DISTINCT employee_id) AS employee_count
    FROM employees
    GROUP BY store_id
)
SELECT
    sr.store_id,
    se.employee_count,
    sr.total_revenue,
    ROUND(
        sr.total_revenue / se.employee_count,
        2
    ) AS revenue_per_employee
FROM store_revenue sr
JOIN store_employees se
    ON sr.store_id = se.store_id
ORDER BY revenue_per_employee DESC
LIMIT 10;

WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS total_orders
    FROM orders
    GROUP BY customer_id
),
customer_revenue AS (
    SELECT
        o.customer_id,
        SUM(oi.qty * oi.price) AS total_revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY o.customer_id
)
SELECT
    CASE
        WHEN co.total_orders = 1 THEN 'One-time'
        WHEN co.total_orders BETWEEN 2 AND 4 THEN 'Low-frequency'
        WHEN co.total_orders BETWEEN 5 AND 9 THEN 'Regular'
        ELSE 'High-frequency'
    END AS customer_segment,
    COUNT(*) AS customer_count,
    ROUND(SUM(COALESCE(cr.total_revenue, 0)), 2) AS total_revenue
FROM customer_orders co
LEFT JOIN customer_revenue cr
    ON co.customer_id = cr.customer_id
GROUP BY customer_segment
ORDER BY total_revenue DESC;

SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT CASE
        WHEN p.amount IS NOT NULL THEN o.order_id
    END) AS orders_with_payment,
    COUNT(DISTINCT CASE
        WHEN oi.order_id IS NOT NULL THEN o.order_id
    END) AS orders_with_items,
    ROUND(SUM(p.amount), 2) AS total_payment_amount,
    ROUND(SUM(oi.qty * oi.price), 2) AS item_level_revenue
FROM orders o
LEFT JOIN payments p
    ON o.order_id = p.order_id
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id;