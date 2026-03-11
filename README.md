# Crane Worldwide Logistics — Analytics Take-Home Exercise



Note on viz tools: I initially attempted to use Power BI Desktop and Hex for visualizations. Both required a corporate domain email for signup/authentication, which wasn't available in this context. I pivoted to Snowflake's built-in Snowsight charting as a practical alternative as it's directly connected to the data and requires no additional tooling. In a real work environment I'd use Tableau, Power BI, or Hex connected to Snowflake.



## Scenario
A new CEO just started and asked for a review of current data to understand "how things are going." This repo contains my exploratory analysis, key SQL queries, visuals, and a summary of findings and recommendations.

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
/sql        — All queries used in the analysis, numbered in order of exploration
/docs       — Written findings, data quality notes, and "what's next" list
/visuals    — Screenshots of visuals
README.md   — This file
```

---

## Key Findings (Summary)

1. **Revenue is growing but net margins are under pressure** — especially in AIR, the highest-volume mode
2. **Warehouse is a hidden gem** — 83%+ net margin, growing volume year over year
3. **Ocean on-time delivery is 74%** — the biggest operational problem in the data
4. **AIR on-time is only 87%** — surprising for a premium service, worth investigating
5. **Industrial vertical dominates volume** — customer concentration risk worth flagging

---

## Data Quality Notes

- Some `CARRIERNAME` values prefixed with `**Deactivated**` — active/inactive carrier flag missing from schema
- `NET_REVENUE_USD` contains negative values — likely cost corrections or write-offs, needs business clarification
- `VERTICAL` contains `N\A` (with backslash) instead of NULL — needs normalization
- `VESSEL` and `VOYAGE` fields in CONTAINERS have significant nulls
- `QUANTITY` in CONTAINERS is a string (`"1 X 40HC"`) — not directly aggregatable without parsing
- Some FILES have `REVENUE_USD = 0` — unclear if these are test records or valid zero-revenue transactions
- `DELIVERY_DATE` is null for a subset of records — may be in-transit or data entry gaps

---

## What I'd Do Next (If This Were Real)

**Data modeling:**
- Build a proper dimensional model: `dim_customer`, `dim_carrier`, `dim_geography`, `fct_shipments`
- Parse `QUANTITY` field in CONTAINERS into numeric container count + type
- Normalize `VERTICAL` values and map `N\A` → NULL
- Add a `transit_days` derived field (DELIVERY_DATE - ORDER_DATE)
- Strip `**Deactivated**` prefix and add `is_active` flag to carrier dimension

**Analysis I'd want to add:**
- Trade lane analysis (origin country → destination country pairs by volume and margin)
- Customer concentration / top 10 customers by revenue
- Carrier performance scorecard (on-time % + avg transit days by carrier)
- YoY growth rates by vertical and product mode
- Late shipment deep-dive: which trade lanes and carriers drive the most late deliveries?

**Production path:**
- Move SQL into dbt models with tests and documentation
- Build a Snowflake-connected Power BI semantic layer with row-level security by vertical
- Schedule daily refresh and add alerting for on-time % drops below threshold
- Validate negative NET_REVENUE rows with finance before publishing margin metrics
