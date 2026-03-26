-- Average Customer Revenue by Cohort 

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
	cohort_year