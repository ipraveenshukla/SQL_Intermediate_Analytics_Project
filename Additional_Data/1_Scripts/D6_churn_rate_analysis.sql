-- this is our final question
-- SELECT MAX(orderdate) FROM sales

WITH customer_last_purchase AS 
(
	SELECT
		customerkey,
		full_name,
		orderdate,
		first_purchase_date,
		ROW_NUMBER() OVER (
			PARTITION BY customerkey
		ORDER BY
			orderdate DESC
		) AS rn
	FROM
		cohort_data
)

	
	
	
	,
churned_customers AS
(
	SELECT
		customerkey,
		full_name,
		orderdate AS last_purchase_date,
		CASE
			WHEN orderdate < (
				SELECT
					MAX(orderdate)
				FROM
					sales
			) - INTERVAL '6 months' THEN 'Churned'
			ELSE 'Active'
		END AS customer_status
	FROM
		customer_last_purchase
	WHERE
		rn = 1
		AND first_purchase_date < (
			SELECT
				MAX(orderdate)
			FROM
				sales
		) - INTERVAL '6 months'
)

SELECT
	customer_status,
	COUNT(customerkey) AS num_customers,
	SUM(COUNT(customerkey)) OVER() AS total_customers,
	ROUND(COUNT(customerkey) / SUM(COUNT(customerkey)) OVER(), 4)* 100 AS status_percentage
FROM
	churned_customers
GROUP BY
	customer_status
