-- Step 1: aggregate revenue per campaign (one row per campaign, prevents duplicated rows after join)
WITH conv AS(
	SELECT 
		campaign_id,
		SUM(revenue_idr) AS total_revenue_idr
	FROM ma_c_conversions
	GROUP BY campaign_id
)
-- Step 2: join to campaigns, then calculate ROAS
SELECT
	cam.campaign_id,
	cam.campaign_name,
	cam.actual_spend_idr,
	COALESCE(con.total_revenue_idr, 0) AS total_revenue_idr,  -- campaigns without conversions get revenue 0
	-- ROAS = total revenue / actual spend, rounded to 4 decimals (small values stay visible)
	ROUND(COALESCE(con.total_revenue_idr, 0)/NULLIF(cam.actual_spend_idr,0),4) AS roas
FROM ma_c_campaigns AS cam
LEFT JOIN conv AS con ON con.campaign_id = cam.campaign_id  -- LEFT JOIN keeps all 500 campaigns
ORDER BY roas DESC;  -- highest ROAS first
