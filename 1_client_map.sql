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
	contract_status,
	COUNT (client_id) AS count_by_status
FROM ma_c_clients
GROUP BY contract_status;

-- Check the city distribution: are clients concentrated in Jakarta only? --
SELECT
	city,
	COUNT (client_id) count_by_city
FROM ma_c_clients
GROUP BY city
ORDER BY COUNT (client_id) DESC;



