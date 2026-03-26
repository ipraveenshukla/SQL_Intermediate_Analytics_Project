CREATE OR REPLACE VIEW cohort_data AS
WITH customer_revenue AS (
    SELECT
        s.customerkey,
        s.orderdate,
        SUM(s.quantity * s.netprice * s.exchangerate) AS net_revenue,
        COUNT(s.orderkey) AS num_orders,
        MAX(c.countryfull) AS countryfull,
        MAX(c.age) AS age,
        MAX(c.givenname) AS givenname,
        MAX(c.surname) AS surname
    FROM sales s
    INNER JOIN customer c ON c.customerkey = s.customerkey
    GROUP BY
        s.customerkey,
        s.orderdate
)
SELECT
    customerkey,
    orderdate,
    net_revenue,
    num_orders,
    countryfull,
    age,
    CONCAT(TRIM(givenname), ' ', TRIM(surname)) AS full_name,
    MIN(orderdate) OVER (PARTITION BY customerkey) AS first_purchase_date,
    EXTRACT(YEAR FROM MIN(orderdate) OVER (PARTITION BY customerkey)) AS cohort_year
FROM customer_revenue cr;