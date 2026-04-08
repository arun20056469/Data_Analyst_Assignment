
SELECT 
    u.user_id,
    b.room_no
FROM users u
JOIN bookings b ON u.user_id = b.user_id
WHERE b.booking_date = (
    SELECT MAX(b2.booking_date)
    FROM bookings b2
    WHERE b2.user_id = u.user_id
);


SELECT 
    bc.booking_id,
    SUM(bc.item_quantity * i.item_rate) AS total_billing_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
JOIN bookings b ON bc.booking_id = b.booking_id
WHERE strftime('%Y-%m', b.booking_date) = '2021-11' 
GROUP BY bc.booking_id;

SELECT 
    bill_id,
    SUM(item_quantity * (SELECT item_rate FROM items WHERE items.item_id = booking_commercials.item_id)) AS bill_amount
FROM booking_commercials
WHERE strftime('%Y-%m', bill_date) = '2021-10' 
GROUP BY bill_id
HAVING bill_amount > 1000;


WITH MonthlyStats AS (
    SELECT 
        strftime('%Y-%m', bill_date) as month_year,
        item_id,
        SUM(item_quantity) as total_qty,
        RANK() OVER (PARTITION BY strftime('%Y-%m', bill_date) ORDER BY SUM(item_quantity) DESC) as max_rank,
        RANK() OVER (PARTITION BY strftime('%Y-%m', bill_date) ORDER BY SUM(item_quantity) ASC) as min_rank
    FROM booking_commercials
    WHERE strftime('%Y', bill_date) = '2021'
    GROUP BY 1, 2
)
SELECT 
    month_year,
    (SELECT item_name FROM items WHERE item_id = m.item_id) as item_name,
    total_qty,
    CASE 
        WHEN max_rank = 1 THEN 'Most Ordered'
        ELSE 'Least Ordered'
    END as status
FROM MonthlyStats m
WHERE max_rank = 1 OR min_rank = 1;

WITH BillValues AS (
    SELECT 
        strftime('%Y-%m', bc.bill_date) as month_year,
        b.user_id,
        bc.bill_id,
        SUM(bc.item_quantity * i.item_rate) as bill_total,
        RANK() OVER (PARTITION BY strftime('%Y-%m', bc.bill_date) ORDER BY SUM(bc.item_quantity * i.item_rate) DESC) as rnk
    FROM booking_commercials bc
    JOIN items i ON bc.item_id = i.item_id
    JOIN bookings b ON bc.booking_id = b.booking_id
    WHERE strftime('%Y', bc.bill_date) = '2021'
    GROUP BY 1, 2, 3
)
SELECT month_year, user_id, bill_id, bill_total
FROM BillValues
WHERE rnk = 2;
