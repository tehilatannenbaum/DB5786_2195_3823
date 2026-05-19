-- =========================================
-- Queries.sql
-- =========================================


-- =========================================
-- QUERY 1A
-- Customers with the highest number of reservations
-- Using JOIN
-- =========================================

SELECT
    c.customer_id,
    c.name AS customer_name,
    c.phone,
    COUNT(r.reservation_id) AS total_reservations,
    SUM(r.number_of_guests) AS total_guests
FROM Customer c
JOIN Reservation r
ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.name, c.phone
ORDER BY total_reservations DESC;


-- =========================================
-- QUERY 1B
-- Same query using subquery
-- =========================================

SELECT
    c.customer_id,
    c.name AS customer_name,
    c.phone,
    reservation_data.total_reservations,
    reservation_data.total_guests
FROM Customer c
JOIN (
    SELECT
        customer_id,
        COUNT(reservation_id) AS total_reservations,
        SUM(number_of_guests) AS total_guests
    FROM Reservation
    GROUP BY customer_id
) AS reservation_data
ON c.customer_id = reservation_data.customer_id
ORDER BY reservation_data.total_reservations DESC;



-- =========================================
-- QUERY 2A
-- Tables without reservations
-- Using LEFT JOIN
-- =========================================

SELECT
    rt.table_id,
    rt.capacity,
    rt.status,
    COUNT(r.reservation_id) AS reservation_count
FROM RestaurantTable rt
LEFT JOIN Reservation r
ON rt.table_id = r.table_id
GROUP BY rt.table_id, rt.capacity, rt.status
HAVING COUNT(r.reservation_id) = 0
ORDER BY rt.table_id;



-- =========================================
-- QUERY 2B
-- Same query using NOT EXISTS
-- =========================================

SELECT
    rt.table_id,
    rt.capacity,
    rt.status,
    0 AS reservation_count
FROM RestaurantTable rt
WHERE NOT EXISTS (
    SELECT 1
    FROM Reservation r
    WHERE r.table_id = rt.table_id
)
ORDER BY rt.table_id;



-- =========================================
-- QUERY 3
-- Monthly reservation statistics using dates
-- =========================================

SELECT
    EXTRACT(YEAR FROM r.date) AS reservation_year,
    EXTRACT(MONTH FROM r.date) AS reservation_month,
    COUNT(r.reservation_id) AS total_reservations,
    SUM(r.number_of_guests) AS total_guests,
    AVG(r.number_of_guests) AS average_guests
FROM Reservation r
GROUP BY
    EXTRACT(YEAR FROM r.date),
    EXTRACT(MONTH FROM r.date)
ORDER BY reservation_year, reservation_month;



-- =========================================
-- QUERY 4
-- Revenue by menu category
-- =========================================

SELECT
    mi.category,
    COUNT(DISTINCT mi.item_id) AS number_of_items,
    SUM(oi.quantity) AS total_items_sold,
    SUM(oi.quantity * mi.price) AS total_revenue,
    AVG(mi.price) AS average_price
FROM MenuItem mi
JOIN OrderItem oi
ON mi.item_id = oi.item_id
GROUP BY mi.category
ORDER BY total_revenue DESC;



-- =========================================
-- UPDATE 1
-- Update unavailable menu items
-- =========================================

UPDATE MenuItem
SET availability = false
WHERE item_id NOT IN (
    SELECT DISTINCT item_id
    FROM OrderItem
);



-- =========================================
-- UPDATE 2
-- Update table status to reserved
-- =========================================

UPDATE RestaurantTable
SET status = 'reserved'
WHERE table_id IN (
    SELECT DISTINCT table_id
    FROM Reservation
    WHERE date >= CURRENT_DATE
);



-- =========================================
-- UPDATE 3
-- Recalculate total order price
-- =========================================

UPDATE Orders
SET total_price = order_totals.new_total
FROM (
    SELECT
        oi.order_id,
        SUM(oi.quantity * mi.price) AS new_total
    FROM OrderItem oi
    JOIN MenuItem mi
    ON oi.item_id = mi.item_id
    GROUP BY oi.order_id
) AS order_totals
WHERE Orders.order_id = order_totals.order_id;



-- =========================================
-- DELETE 1
-- Delete cancelled orders
-- =========================================

DELETE FROM Orders
WHERE status = 'cancelled';



-- =========================================
-- DELETE 2
-- Delete old reservations
-- =========================================

DELETE FROM Reservation
WHERE EXTRACT(YEAR FROM date) < EXTRACT(YEAR FROM CURRENT_DATE);



-- =========================================
-- DELETE 3
-- Delete unavailable menu items
-- =========================================

DELETE FROM MenuItem
WHERE availability = false;