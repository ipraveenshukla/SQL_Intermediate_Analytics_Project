-- using the NULLIF and COALESCE funcition

-- NULLIF - turns matching values to NULL
-- COALESCE - converts NULL values to given condition 

WITH sales_data AS
		(SELECT 
			customerkey,
			SUM(netprice*quantity*exchangerate) AS net_revenue
		FROM
			sales
		GROUP BY
			customerkey)
	
SELECT 
	c.customerkey,
	sd.net_revenue AS raw,
	-- replacing NULL to 0
	COALESCE(sd.net_revenue, 0) AS cleaned
	
	
FROM customer c 
LEFT JOIN sales_data sd ON sd.customerkey = c.customerkey
ORDER BY
	c.customerkey;
	
	
-- similarily we can get average revenue for customers that have sales and average revenue of ALL customers using NULL IF 👇
	
	
	WITH sales_data AS
		(SELECT 
			customerkey,
			SUM(netprice*quantity*exchangerate) AS net_revenue
		FROM
			sales
		GROUP BY
			customerkey)
	
SELECT 
	AVG(sd.net_revenue) AS spending_cutomers,
	AVG(NULLIF(sd.net_revenue,0)) AS all_customers
	
FROM customer c 
LEFT JOIN sales_data sd ON sd.customerkey = c.customerkey