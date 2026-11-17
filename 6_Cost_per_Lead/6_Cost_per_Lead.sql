-- Channel scorecard: CPL and lead quality for lead_gen and conversions campaigns --

-- Step 1: aggregate leads per campaign (one row per campaign, avoids duplicated rows after join)
WITH lead_agg AS(
	SELECT 
		campaign_id,
		COUNT(lead_id) AS total_leads,
		SUM (lead_score) AS total_lead_score
	FROM ma_c_leads
	GROUP BY campaign_id
)
-- Step 2: join to campaigns, then aggregate per channel
SELECT
	cam.channel,
	SUM(cam.actual_spend_idr) AS total_spend_idr,
	COALESCE(SUM(lagg.total_leads),0) AS total_leads,  -- channels without leads show 0
	-- CPL = total spend / total leads (NULLIF avoids divide-by-zero)
	ROUND(SUM(cam.actual_spend_idr) / NULLIF(SUM(lagg.total_leads),0),0) AS cpl_idr,
	-- weighted avg lead score = sum of scores / total leads
	ROUND(SUM(lagg.total_lead_score) / NULLIF(SUM(lagg.total_leads),0),2) AS avg_lead_score
FROM ma_c_campaigns AS cam
LEFT JOIN lead_agg AS lagg ON lagg.campaign_id = cam.campaign_id  -- keep campaigns without leads
WHERE cam.objective IN ('lead_gen', 'conversions')  -- filter per instruction
GROUP BY cam.channel
ORDER BY cpl_idr ASC;  -- cheapest per lead first
