-- Step 1: join campaigns to ad spend to get channel for each spend row
WITH join_channel AS (
SELECT
 		cc.campaign_id AS campaign_id,
		cc.channel,
		ads.clicks AS clicks,
		COALESCE(ads.conversions, 0) AS conversions,  -- blank conversions treated as 0
		ads.spend_idr AS spend_idr 
	FROM ma_c_campaigns AS cc
	INNER JOIN ma_c_adspend AS ads ON cc.campaign_id = ads.campaign_id  -- keep only campaigns that have spend data
)
-- Step 2: aggregate per channel, then calculate cost ratios
SELECT
	channel,
	-- CPC = total spend / total clicks (0 if no clicks, avoids divide-by-zero)
	ROUND(CASE WHEN SUM(clicks) > 0 THEN SUM(spend_idr) / SUM(clicks) ELSE 0 END, 2) AS cpc,
	-- CPA = total spend / total conversions (0 if no conversions, avoids divide-by-zero)
	ROUND(CASE WHEN SUM(conversions) > 0 THEN SUM(spend_idr) / SUM(conversions) ELSE 0 END, 2) AS cpa
FROM join_channel
GROUP BY channel
ORDER BY cpa ASC;  -- cheapest per conversion first
