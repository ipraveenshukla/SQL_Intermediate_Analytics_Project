
SELECT 
	cohort_year,
	SUM(net_revenue) AS total_revenue,
	COUNT(DISTINCT customerkey) AS total_customers,
	SUM(net_revenue) / COUNT(DISTINCT customerkey) AS avg_customer_revenue
FROM 
	cohort_data
GROUP BY 
	cohort_year;

------------------------------------------------------------------------------

SELECT 
	cohort_year,
	SUM(net_revenue) AS total_revenue,
	COUNT(DISTINCT customerkey) AS total_customers,
	SUM(net_revenue) / COUNT(DISTINCT customerkey) AS avg_customer_revenue
FROM 
	cohort_data
WHERE
	orderdate = first_purchase_date
GROUP BY 
	cohort_year;

------------------------------------------------------------------------------



WITH purchase_days AS 
(
SELECT 
	customerkey,
	net_revenue,
	orderdate - MIN(orderdate) OVER (PARTITION BY customerkey) AS days_since_first_purchase
	
FROM
	cohort_data 
)


SELECT 
	days_since_first_purchase,
	SUM(net_revenue) AS total_revenue,
	SUM(net_revenue) / (SELECT SUM(net_revenue) FROM cohort_data)*100 AS pct_of_total_revenue,
	SUM(SUM(net_revenue) / (SELECT SUM(net_revenue) FROM cohort_data)*100) OVER (ORDER BY days_since_first_purchase) AS cumulative_pct_of_total_revenue
FROM purchase_days
GROUP BY 
	days_since_first_purchase
ORDER BY 
	days_since_first_purchase
LIMIT 51;
	