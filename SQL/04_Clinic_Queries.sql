
SELECT 
    sales_channel,
    SUM(amount) as total_revenue
FROM clinic_sales
WHERE strftime('%Y', datetime) = '2021'
GROUP BY sales_channel;


SELECT 
    c.name,
    SUM(cs.amount) as total_spent
FROM clinic_sales cs
JOIN customer c ON cs.uid = c.uid
WHERE strftime('%Y', cs.datetime) = '2021'
GROUP BY c.name
ORDER BY total_spent DESC
LIMIT 10;


WITH MonthlyRevenue AS (
    SELECT strftime('%m', datetime) as month, SUM(amount) as revenue
    FROM clinic_sales
    WHERE strftime('%Y', datetime) = '2021'
    GROUP BY month
),
MonthlyExpense AS (
    SELECT strftime('%m', datetime) as month, SUM(amount) as expense
    FROM expenses
    WHERE strftime('%Y', datetime) = '2021'
    GROUP BY month
)
SELECT 
    COALESCE(r.month, e.month) as month,
    COALESCE(r.revenue, 0) as revenue,
    COALESCE(e.expense, 0) as expense,
    (COALESCE(r.revenue, 0) - COALESCE(e.expense, 0)) as profit,
    CASE 
        WHEN (COALESCE(r.revenue, 0) - COALESCE(e.expense, 0)) > 0 THEN 'Profitable'
        ELSE 'Not-Profitable'
    END as status
FROM MonthlyRevenue r
FULL OUTER JOIN MonthlyExpense e ON r.month = e.month
ORDER BY month;

WITH ClinicProfit AS (
    SELECT 
        cl.city,
        cl.clinic_name,
        (COALESCE(SUM(s.amount), 0) - COALESCE(SUM(e.amount), 0)) as net_profit,
        RANK() OVER (PARTITION BY cl.city ORDER BY (COALESCE(SUM(s.amount), 0) - COALESCE(SUM(e.amount), 0)) DESC) as rnk
    FROM clinics cl
    LEFT JOIN clinic_sales s ON cl.cid = s.cid AND strftime('%Y-%m', s.datetime) = '2021-09'
    LEFT JOIN expenses e ON cl.cid = e.cid AND strftime('%Y-%m', e.datetime) = '2021-09'
    GROUP BY cl.city, cl.clinic_name
)
SELECT city, clinic_name, net_profit
FROM ClinicProfit
WHERE rnk = 1;


WITH ClinicProfit AS (
    SELECT 
        cl.state,
        cl.clinic_name,
        (COALESCE(SUM(s.amount), 0) - COALESCE(SUM(e.amount), 0)) as net_profit,
        RANK() OVER (PARTITION BY cl.state ORDER BY (COALESCE(SUM(s.amount), 0) - COALESCE(SUM(e.amount), 0)) ASC) as rnk
    FROM clinics cl
    LEFT JOIN clinic_sales s ON cl.cid = s.cid AND strftime('%Y-%m', s.datetime) = '2021-09'
    LEFT JOIN expenses e ON cl.cid = e.cid AND strftime('%Y-%m', e.datetime) = '2021-09'
    GROUP BY cl.state, cl.clinic_name
)
SELECT state, clinic_name, net_profit
FROM ClinicProfit
WHERE rnk = 2;