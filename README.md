# Crane Worldwide Logistics — Analytics Take-Home Exercise

A new CEO just started and asked for a review of current data to understand "how things are going." This repo contains my exploratory SQL, findings, data quality observations, and an interactive dashboard.

---

## Snowflake Setup

```sql
use role screening_bi;
use warehouse screening_wh;
use database screening_bi;
```

---

## Repo Structure

```
/sql        — Queries used in the analysis, numbered in order of exploration
/docs       — Full findings, data quality notes, and what I'd do next
/visuals    — Interactive dashboard + chart screenshots
README.md   — This file
```

**Dashboard:** [visuals/dashboard.html](https://ce-craneww.github.io/craneww/visuals/dashboard.html)
**Full findings:** [docs/findings.md](docs/findings.md)

---

## Key Findings

1. **Revenue normalized post-boom but margins are improving** — net margin grew from 24% in 2021 to 30% in 2023 even as revenue declined 38% from the 2022 peak
2. **Warehouse is the highest-margin service at 84%** — and volume is growing year over year
3. **Air on-time delivery is only 87%** — surprising for a premium mode, customers are paying for speed and reliability
4. **Ocean on-time is 74%** — expected given complexity, but worth tracking by carrier and trade lane
5. **Cruise/Marine/Hospitality vertical runs 42% margin** at $322K avg revenue per shipment — small volume, high strategic value
6. **CN→US dominates trade lanes** at 19,812 shipments but only 19.8% margin — US→GB at 34.3% is the standout

---

## Note on Visualizations

Power BI and Hex both require a corporate domain email to sign up, which wasn't available in this context. I built an HTML dashboard using Chart.js with hardcoded values from the verified SQL query results — open `visuals/dashboard.html` in any browser. The dashboard is not connected live to Snowflake. In production I'd connect Power BI or Tableau directly to the data source for live refresh.
