# Crane Worldwide — Findings & CEO Summary

## The Ask
A new CEO asked for a review of the current data to understand "how things are going." This is a summary of what the data shows, what I'd flag as priorities, and where I'd dig deeper.

---

## Dataset Overview
- **3 years of data:** January 2021 – December 2023
- **578,215 shipment records** across Air, Ocean, Ground, Customs Brokerage, Warehouse, and Rail
- **10,000 customers** across 12 industry verticals
- **57,821 container records** linked to ocean/rail shipments

---

## What the Data Says

### 1. Revenue normalized post-boom — but margins are actually improving

| Year | Total Revenue | Total Net Revenue | Net Margin % |
|------|--------------|------------------|--------------|
| 2021 | $8.4B | $2.0B | 24.1% |
| 2022 | $9.8B | $2.5B | 25.8% |
| 2023 | $6.1B | $1.8B | 29.6% |

Revenue peaked in 2022 (likely driven by the post-COVID freight boom and elevated shipping rates) and pulled back sharply in 2023 — a 38% drop. However, **net margin improved every single year: 24% → 26% → 30%.** This is the most important headline for the CEO: the business shed lower-margin volume during the normalization but retained its most profitable work. That's a sign of pricing discipline and improving customer/lane mix, not a business in decline.

---

### 2. Warehouse is the highest-margin service — and it's growing

| Mode | Net Margin | Shipments (2023) |
|------|-----------|-----------------|
| Warehouse | ~84% | 9,943 |
| Customs Brokerage | ~34% | 16,666 |
| Ground | ~24% | 69,299 |
| Air | ~22% | 70,728 |
| Ocean | ~22% | 42,083 |

Warehouse runs at 83-84% net margin every year. It's a small slice of volume but a disproportionate contributor to profit. **Strategic question for the CEO: is there an opportunity to grow this service line?**

---

### 3. On-time delivery has a real problem in Air and Ocean

| Mode | On-Time % | % of Records Measurable |
|------|-----------|------------------------|
| Ground | 95.4% | 85.4% |
| Warehouse | 95.2% | 4.2% ⚠️ |
| Customs Brokerage | 91.5% | 15.1% ⚠️ |
| **Air** | **87.0%** | **91.8%** |
| **Ocean** | **74.0%** | **93.3%** |
| Rail | 66.0% | 97.9% |

**The only statistically reliable on-time figures are Air, Ocean, and Rail** — 91-98% of those shipments have both delivery and requested delivery dates populated.

**Warehouse (4.2% measurable) and Customs Brokerage (15.1% measurable) on-time stats should not be cited** — the sample is too small and likely non-representative. This is a data quality issue worth investigating: why are most warehouse and customs records missing one or both dates?

**Air at 87% is the most actionable finding.** Customers choosing air freight are paying a premium specifically for speed and reliability. A 13% late rate is a customer satisfaction and retention risk. I'd want to drill into which carriers and trade lanes are driving the lateness before drawing final conclusions.

**Ocean at 74%** is more expected given port congestion and transit complexity, but still worth tracking by trade lane and carrier.

---

### 4. Industrial dominates volume — but it's not the profit leader

| Vertical | Shipments | Total Revenue | Net Margin % |
|----------|-----------|--------------|--------------|
| Industrial | 127,838 | $6.4B | 25.3% |
| Energy | 130,131 | $4.8B | 23.5% |
| Retail | 59,745 | $4.4B | 26.5% |
| HiTech | 98,791 | $2.9B | 27.5% |
| Automotive | 37,224 | $2.2B | 22.6% |
| Life Science | 54,533 | $1.5B | 32.2% |
| Aerospace | 37,174 | $1.0B | 29.4% |
| **Cruise/Marine/Hospitality** | **1,359** | **$438M** | **41.6%** |
| Government | 6,781 | $283M | 23.4% |
| Overseas Agent Partner | 10,067 | $235M | 32.4% |
| Doc Turnover | 1,598 | $49M | 29.6% |
| FMCG | 89 | $249K | 51.0% |
| N\A | 285 | $94M | 63.7%* |

*N\A margin is not reliable — these records need vertical classification before being included in margin reporting.

**Key insight:** Industrial and Energy make up the majority of volume but sit at the lower end of margin. **Life Science (32%), Aerospace (29%), and Cruise/Marine (42%) are high-margin verticals worth growing.** HiTech at 27.5% margin with nearly 99K shipments is also a strong performer.

**Customer concentration risk:** Industrial alone accounts for ~22% of all shipments. If that sector softens, the volume impact would be significant.

---

## Data Quality Issues Observed

| Issue | Impact |
|-------|--------|
| `NET_REVENUE_USD` contains negative values | Margin calculations may be understated in some segments |
| `CARRIERNAME` has `**Deactivated**` prefix on some records | Can't cleanly filter active vs inactive carriers |
| `VERTICAL = 'N\A'` (not NULL) | Breaks standard null filtering |
| `QUANTITY` in CONTAINERS is a string (e.g., "1 X 40HC") | Can't aggregate without parsing |
| `VESSEL` / `VOYAGE` nulls in CONTAINERS | Limits ocean carrier analysis |
| Missing `DELIVERY_DATE` on some records | On-time % denominator is incomplete |
| `REVENUE_USD = 0` on some records | May skew averages; unclear if valid |

**My approach:** Call these out, document them, and move on. In a production setting I'd file data quality tickets and work with the source system owners to resolve upstream.

---

## What I'd Do Next

- Trade lane analysis (top origin → destination pairs by volume and margin)
- Top 10 customer revenue concentration
- Carrier-level on-time scorecard
- YoY growth rates by vertical

**To go from exploration to production:**
- Model this in dbt: `dim_customer`, `dim_carrier`, `dim_geography`, `fct_shipments`
- Publish a Power BI report with CEO-level KPI page + drill-through by mode/vertical/geography
- Add data quality tests in dbt (not_null, accepted_values, relationships)
- Resolve data quality issues upstream before publishing margin metrics broadly
- Add row-level security so regional managers only see their data
