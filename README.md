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
