# Data Analyst at a Marketing Agency
## Project Overview
### 1. Client Map: Which Industry Is the Biggest?
**Business question:** The Account Director asked me to put together a quick overview of the agency’s client portfolio. Out of 50 clients, they want to know which industries contribute the most to monthly budget, how many contracts are still running in each industry, and whether clients are concentrated in just one city.

Approach: Using SQL on the ma_c_clients table, I:

  1. Calculated the total and average monthly_budget_idr per industry (SUM, AVG, GROUP BY), sorted from highest to lowest, to see which industries contribute the most.
  2. Compared the number of active, paused, and terminated clients in each industry (COUNT with CASE WHEN) to assess contract health.
  3. Counted clients per city to check whether they are concentrated in Jakarta.

Output: A concise client portfolio summary ready to use in a team onboarding slide.
