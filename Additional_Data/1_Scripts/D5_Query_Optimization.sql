-- EXPLAIN and EXPLAIN ANALYZE


EXPLAIN
SELECT 
	*
FROM 
	sales;

EXPLAIN ANALYZE
SELECT 
	*
FROM 
	sales;

-- using WHERE instead of HAVING
	
EXPLAIN ANALYZE
SELECT 
	customerkey,
	SUM(netprice*exchangerate*quantity) AS net_revenue
FROM 
	sales
GROUP BY
	customerkey
HAVING SUM(netprice*exchangerate*quantity) > 50000;


EXPLAIN ANALYZE
SELECT 
	customerkey,
	SUM(netprice*exchangerate*quantity) AS net_revenue
FROM 
	sales
WHERE orderdate > '2022-01-01'
GROUP BY
	customerkey

	