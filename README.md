# Data Analyst at a Marketing Agency
## Project Overview
This portfolio simulates my role as a data analyst at a marketing agency. I receive a variety of assignments from my manager, each a business question I need to answer with data. These assignments cover mapping the client portfolio, analyzing the leads funnel, tracking monthly ad spend trends, evaluating channel and campaign performance through ROAS and cost per lead, and building a client ROI dashboard and lead scoring. I turn each assignment into an output ready to support the team’s decisions. The tools I use are SQL, Google Sheets, and Looker Studio.

Google Spreadsheet: https://docs.google.com/spreadsheets/d/1ecJthfTLWu-CEyPuafT6RgZYOEB4HgHoBCx8byGxXA4/edit?usp=sharing

Looker Studio: https://datastudio.google.com/reporting/44843036-f5b4-42dc-bf0f-bcc727c70d3f

### 1. Client Map: Which Industry Is the Biggest?
**Business question:** The Account Director asked me to put together a quick overview of the agency’s client portfolio. Out of 50 clients, they want to know which industries contribute the most to monthly budget, how many contracts are still running in each industry, and whether clients are concentrated in just one city.

**Approach:** Using SQL on the `clients_cleaned` table, I:

  1. Calculated the total and average monthly_budget_idr per industry (SUM, AVG, GROUP BY), sorted from highest to lowest, to see which industries contribute the most.
  2. Compared the number of active, paused, and terminated clients in each industry (COUNT with CASE WHEN) to assess contract health.
  3. Counted clients per city to check whether they are concentrated in Jakarta.

**Output:** A concise client portfolio summary ready to use in a team onboarding slide.

**Tools:** SQL.


### 2. Leads Funnel: Where Do Prospects Get Stuck?

**Business question:** The Growth Team asked me to trace the journey of the agency’s 2,500 leads. They want to know how many are still new, contacted, or qualified, how many have converted, and how many were ultimately lost. They also want to know which stage leaks the most leads.

**Approach:** I analyzed the lead status data by:

  1. Counting leads per status along with each status’s share of the total, to see how leads are distributed across stages.
  2. Building a cumulative funnel (total leads, contacted, qualified, converted), since status only shows a lead’s latest position. A lead that is already qualified is counted as having passed the contacted stage.
  3. Calculating the drop-off percentage between stages to find where the most leads are lost.

**Output:** A simple funnel chart with a one-sentence insight. The biggest leak is between the qualified and converted stages, where more than half of qualified leads have not yet converted.

**Tools:** Google Sheet (Pivot Table + Line Chart).


### 3. Monthly Advertising Spend Trends: When Does the Agency Spend the Most?

**Business question:** The Finance team wants to understand the agency's advertising spending patterns over the past three years. They want to identify the months with the highest and lowest spending, as well as understand how advertising expenditure trends change over time.

**Approach:** Using Google Sheets and the `adspend_cleaned` table, I:

1. Aggregated total `spend_idr`, `clicks`, and `conversions` by month using `spend_date` to identify monthly advertising spending patterns.
2. Identified the months with the highest and lowest values across spending, clicks, and conversions.
3. Identified months when advertising spend increased while conversions declined, to highlight periods when higher advertising budgets were not followed by improved campaign results.

**Output:** A line chart showing monthly advertising spend trends, accompanied by notes highlighting changes in spending patterns and potential budget inefficiencies.

**Note:** Approximately 10% of records in the `adspend_cleaned` table have missing `conversions` values, meaning the actual number of conversions may be slightly higher than the recorded figures.

**Tools:** Google Sheets (Pivot Table + Line Chart).


### 4. Channel Performance: Which Channel Delivers the Best Results?

**Business question:** The Head of Performance wants to identify which advertising channels are the most efficient in terms of cost per click (CPC) and cost per acquisition (CPA). The goal is to compare the performance of each channel and identify which ones generate conversions at the lowest cost.

**Approach:** Using SQL on the `campaigns_cleaned` and `adspend_cleaned` tables, I:

  1. Joined the `campaigns` and `ad_spend` tables to connect advertising channel information with spending, clicks, and conversions data.
  2. Aggregated total spending, clicks, and conversions for each channel to calculate CPC and CPA.
  3. Ranked advertising channels by CPA, from the lowest to the highest, to identify the most cost-efficient channels in terms of cost per conversion and support campaign evaluation and budget allocation decisions.

**Output:** A channel performance scorecard displaying CPC and CPA for each channel, including rankings based on CPA as a basis for evaluating cost efficiency.

**Tools:** SQL.


### 5. Campaign ROAS: Which Campaigns Pay Back the Investment?

**Business question:** Clients often ask, “Is my advertising worth it?” Return on Ad Spend (ROAS), calculated as revenue divided by spend, answers that question. The goal is to evaluate 500 campaigns and identify which ones generate profitable returns and which ones are simply burning budget.

**Approach:** Using SQL on the campaigns and conversions tables, followed by Google Sheets for the final classification, I:

  1. Aggregated total revenue per campaign from the conversions table using a CTE, so that each campaign has only one row and no duplicated rows appear after the join.
  2. Joined the aggregated revenue to the campaigns table using a LEFT JOIN, so that all 500 campaigns were kept. Campaigns without conversions were assigned a revenue of zero using COALESCE, resulting in a ROAS of zero instead of being dropped from the data.
  3. Calculated ROAS for each campaign by dividing total revenue by actual_spend_idr, using NULLIF to prevent division-by-zero errors, then ranked campaigns from the highest to the lowest ROAS.
  4. Exported the SQL results to Google Sheets and created a flag column using an IF formula: campaigns with ROAS of 2 or higher were flagged as “Scale”, those between 1 and 2 as “Maintain”, and those below 1 as “Pause”.

**Output:** A campaign performance table displaying total revenue, spend, and ROAS for each campaign, along with a “Scale”, “Maintain”, or “Pause” flag, ready to be presented directly in a client meeting.

**Tools:** SQL, Google Sheets.


### 6. Cost per Lead: Which Channel Is the Most Cost-Efficient?

**Business question:** Campaigns with the `lead_gen` and `conversions` objectives both generate leads, and the goal is to collect leads as cheaply as possible. Cost per Lead (CPL), calculated as ad spend divided by the number of leads, shows which channels are the most cost-efficient. However, a low cost alone is not enough if the leads themselves are low quality. The goal is to identify which channels deliver leads at a low cost without sacrificing lead quality.

**Approach:** Using SQL on the `campaigns` and `leads` tables, followed by Google Sheets and Looker Studio for the matrix visualizations, I:

  1. Filtered campaigns to include only those with the `lead_gen` and `conversions` objectives, since both types of campaigns contribute to lead generation.
  2. Aggregated the number of leads and total `lead_score` per campaign from the `leads` table using a CTE, so that each campaign has only one row and no duplicated rows appear after the join.
  3. Joined the aggregated results to the `campaigns` table using a LEFT JOIN, so that campaigns without leads were still included. Then calculated total spend and number of leads per channel, along with CPL (total spend divided by total leads), using NULLIF to prevent division-by-zero errors.
  4. Calculated the average `lead_score` per channel (total score divided by total leads) so that channels with a low CPL but poor lead quality could be identified, then ranked channels from the lowest to the highest CPL.
  5. Built two matrices in Google Sheets and Looker Studio: Lead Volume vs. Lead Quality, and Cost per Lead vs. Lead Quality.

**Output:** A Channel Performance Summary table showing Spend, Leads, CPL, and Lead Score for each channel, along with two simple 2x2 matrices (Lead Volume vs. Lead Quality and Cost per Lead vs. Lead Quality), available in both Google Sheets and Looker Studio versions, serving as an ad-hoc answer for the performance team.

**Tools:** SQL, Google Sheets, Looker Studio.
