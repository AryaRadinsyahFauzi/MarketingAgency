-- Step 1: clean the acquisition channel field (CTE)
WITH channel_clean AS(
SELECT
	lead_id,
	created_date,
	city,
	-- leads with an empty acquisition_channel are labeled 'Unknown' instead of being dropped (keeps all 2,500 leads)
	COALESCE(acquisition_channel, 'Unknown') AS acquisition_channel
FROM ma_c_leads)
-- Step 2: flag each lead as tracked or untracked
SELECT
	lead_id,
	created_date,
	city,
	acquisition_channel,
	-- known_status: 'is_unknown' = UTM not tracked, 'is_known' = acquisition channel recorded
	CASE 
		WHEN acquisition_channel = 'Unknown' THEN 'is_unknown'
		ELSE 'is_known'
	END AS known_status
FROM channel_clean
