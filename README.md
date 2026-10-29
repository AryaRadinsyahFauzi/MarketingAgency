# Data Analyst at a Marketing Agency
## Project Overview
This portfolio simulates my role as a data analyst at a marketing agency. I receive a variety of assignments from my manager, each a business question I need to answer with data. These assignments cover mapping the client portfolio, analyzing the leads funnel, tracking monthly ad spend trends, evaluating channel and campaign performance through ROAS and cost per lead, and building a client ROI dashboard and lead scoring. I turn each assignment into an output ready to support the team’s decisions. The tools I use are SQL, Google Sheets, and Looker Studio.

Google Spreadsheet: https://docs.google.com/spreadsheets/d/1ecJthfTLWu-CEyPuafT6RgZYOEB4HgHoBCx8byGxXA4/edit?usp=sharing
Looker Studio:

### 1. Client Map: Which Industry Is the Biggest?
**Business question:** The Account Director asked me to put together a quick overview of the agency’s client portfolio. Out of 50 clients, they want to know which industries contribute the most to monthly budget, how many contracts are still running in each industry, and whether clients are concentrated in just one city.

Approach: Using SQL on the `ma_c_clients` table, I:

  1. Calculated the total and average monthly_budget_idr per industry (SUM, AVG, GROUP BY), sorted from highest to lowest, to see which industries contribute the most.
  2. Compared the number of active, paused, and terminated clients in each industry (COUNT with CASE WHEN) to assess contract health.
  3. Counted clients per city to check whether they are concentrated in Jakarta.

Output: A concise client portfolio summary ready to use in a team onboarding slide.


### 2. Leads Funnel: Where Do Prospects Get Stuck?

**Business question:** The Growth Team asked me to trace the journey of the agency’s 2,500 leads. They want to know how many are still new, contacted, or qualified, how many have converted, and how many were ultimately lost. They also want to know which stage leaks the most leads.

Approach: I analyzed the lead status data by:

Counting leads per status along with each status’s share of the total, to see how leads are distributed across stages.
Building a cumulative funnel (total leads, contacted, qualified, converted), since status only shows a lead’s latest position. A lead that is already qualified is counted as having passed the contacted stage.
Calculating the drop-off percentage between stages to find where the most leads are lost.

Output: A simple funnel chart with a one-sentence insight. The biggest leak is between the qualified and converted stages, where more than half of qualified leads have not yet converted.
