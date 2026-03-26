-- Customer Segmentation (Who Are Our Most Valuable Customers?)
-- in this project we will analyse customers group by their expenditures

 

SELECT
	full_name,
	customerkey,
	SUM(net_revenue) AS total_ltv
FROM
	cohort_data
GROUP BY
	customerkey,
	full_name;


-- now getting the 25th and 75th percentile

WITH customer_data AS (
		SELECT
	full_name,
	customerkey,
	SUM(net_revenue) AS total_ltv
FROM
	cohort_data
GROUP BY
	customerkey,
	full_name
)

 SELECT 
 	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total_ltv) AS cust_25th_percentile,
 	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY total_ltv) AS cust_75th_percentile
 	FROM customer_data;

 -- creating CTE for both
 	
 	
WITH customer_data AS (
		SELECT
	full_name,
	customerkey,
	SUM(net_revenue) AS total_ltv
FROM
	cohort_data
GROUP BY
	customerkey,
	full_name
)
, customer_segment AS

 (SELECT 
 	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total_ltv) AS cust_25th_percentile,
 	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY total_ltv) AS cust_75th_percentile
 	FROM customer_data)

SELECT 

	d.full_name,
	d.customerkey,
	d.total_ltv,
	
CASE
	WHEN s.cust_25th_percentile > d.total_ltv THEN '3-Low Value'
	WHEN s.cust_75th_percentile < d.total_ltv THEN '1-High Value'
	ELSE '2-Medium Value'
END AS customer_segment

FROM customer_data d,
	 customer_segment s;


-- finally
	 
WITH customer_data AS (
		SELECT
	full_name,
	customerkey,
	SUM(net_revenue) AS total_ltv
FROM
	cohort_data
GROUP BY
	customerkey,
	full_name
)
, customer_segment AS

 (SELECT 
 	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total_ltv) AS cust_25th_percentile,
 	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY total_ltv) AS cust_75th_percentile
 	FROM customer_data)
 	
 	, customer_value AS

(SELECT 

	d.full_name,
	d.customerkey,
	d.total_ltv,
	
CASE
	WHEN s.cust_25th_percentile > d.total_ltv THEN '3-Low Value'
	WHEN s.cust_75th_percentile < d.total_ltv THEN '1-High Value'
	ELSE '2-Medium Value'
END AS customer_segment

FROM customer_data d,
	 customer_segment s	)
	 
	 
	 
	 
SELECT
	customer_segment,
	SUM(total_ltv) / (SELECT SUM(total_ltv) FROM customer_value)*100 AS ltv_percentage,
	SUM(total_ltv) AS total_ltv,
	COUNT(customerkey) AS customer_count,
	SUM(total_ltv)/COUNT(customerkey) AS avg_ltv
	
FROM 
customer_value 
GROUP BY
	customer_segment	 
ORDER BY
	customer_segment

