-- ## Client Map: Which Industries Are the "Fattest" ## --
-- Total and average monthly_budget_idr per industry --
SELECT
	industry,
	SUM(monthly_budget_idr) AS sum_monthly_budget_idr,
	ROUND(AVG(monthly_budget_idr),0) AS avg_monthly_budget_idr
FROM ma_c_clients
GROUP BY industry
ORDER BY sum_monthly_budget_idr DESC;

-- Compare the number of active vs paused vs terminated clients in each industry--
SELECT
	Industry,
	SUM(CASE WHEN contract_status = 'active' THEN 1 END) AS active,
	SUM(CASE WHEN contract_status = 'paused' THEN 1 END) AS paused,
	SUM(CASE WHEN contract_status = 'terminated' THEN 1 END) AS terminated
FROM ma_c_clients
GROUP BY industry
ORDER BY industry;

-- Check the city distribution: are clients concentrated in Jakarta only? --
SELECT
	city,
	COUNT (client_id) count_by_city
FROM ma_c_clients
GROUP BY city
ORDER BY COUNT (client_id) DESC;



