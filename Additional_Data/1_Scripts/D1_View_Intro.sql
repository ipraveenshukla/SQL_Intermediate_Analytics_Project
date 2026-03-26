WITH customer_table AS (
         SELECT s.customerkey,
            s.orderdate,
            count(s.orderkey) AS num_orders,
            sum(s.exchangerate * s.netprice * s.quantity::double precision) AS net_revenue,
            c.countryfull AS country,
            c.age,
            c.givenname,
            c.surname
           FROM sales s
             LEFT JOIN customer c ON s.customerkey = c.customerkey
          GROUP BY s.customerkey, s.orderdate, c.countryfull, c.age, c.givenname, c.surname
        )
 SELECT customerkey,
    orderdate,
    num_orders,
    net_revenue,
    country,
    age,
    givenname,
    surname,
    min(orderdate) OVER (PARTITION BY customerkey) AS first_purchase_date,
    EXTRACT(year FROM min(orderdate) OVER (PARTITION BY customerkey)) AS cohort_year
   FROM customer_table ct;


-- using the view

SELECT
    cohort_year,
    SUM(net_revenue) AS total_revenue
FROM cohort_data 
GROUP BY 
    cohort_year
ORDER BY cohort_year;