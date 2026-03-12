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

### 5. Trade lanes — CN→US dominates but isn't the margin leader

| Origin | Destination | Shipments | Revenue | Net Margin % |
|--------|------------|-----------|---------|-------------|
| CN | US | 19,812 | $2.3B | 19.8% |
| US | US | 14,684 | $573.8M | 22.2% |
| US | GB | 11,036 | $315.3M | 34.3% |
| CN | GB | 8,138 | $400.0M | 23.0% |
| BR | BR | 8,024 | $89.6M | 16.5% |
| US | BR | 7,990 | $337.4M | 30.3% |
| IN | US | 7,912 | $620.1M | 18.6% |
| TH | US | 3,445 | $827.5M | 20.0% |
| AR | AR | 4,849 | $67.1M | 49.1% |

China→US is the volume king at 19,812 shipments but margin is only 19.8% — below average. **US→GB at 34.3% margin is the standout high-margin lane.** TH→US is notable — only 3,445 shipments but $827.5M revenue ($240K avg per shipment), suggesting very high-value cargo. AR→AR at 49.1% is likely customs brokerage heavy.

---

### 6. Customer concentration — top 10 revenue analysis

| Customer | Vertical | Shipments | Revenue | Net Margin % |
|----------|----------|-----------|---------|-------------|
| Deadly Really Vital Hen | Retail | 748 | $834M | 12.9% |
| New Newt | Energy | 2,066 | $1.76B | 24.6% |
| Neat Mink | Industrial | 2,027 | $674.7M | 26.3% |
| New Tapir | Energy | 1,123 | $518.9M | 16.2% |
| Nearly Ace Frog | Retail | 1,585 | $449.5M | 20.4% |
| Funny Mako | Industrial | 7,412 | $374.7M | 24.9% |
| Funny Tiger | Industrial | 8,358 | $373.1M | 29.9% |
| Unduly Direct Raven | Automotive | 3,658 | $365.2M | 20.5% |
| Deadly Rarely Driven Flea | HiTech | 5,083 | $357.9M | 26.5% |
| Deadly Oddly Poetic Marten | Retail | 4,008 | $255M | 10.6% |

**"New Newt" (Energy) at $1.76B is the single largest customer** — one customer driving that much revenue is a significant concentration risk. If they churn or reduce volume, the impact is immediate and material.

**"Deadly Really Vital Hen" (Retail) is a red flag** — 748 shipments, $834M revenue ($1.1M avg per shipment), but only 12.9% margin. Massive revenue, below-average profit. Worth a strategic conversation about whether this relationship is being managed at the right price point.

**"Deadly Oddly Poetic Marten" (Retail) at 10.6%** is the lowest margin in the top 10 — high volume, low return.

---

## Data Quality Issues Observed

| Issue | Count | Impact |
|-------|-------|--------|
| Missing `DELIVERY_DATE` | 115,894 (20% of records) | Primary driver of low on-time measurability for Warehouse and Customs Brokerage |
| Negative `NET_REVENUE_USD` | 30,674 (5.3% of records) | Air accounts for 14,226 records (-$120.8M) — material enough to affect margin reporting; needs finance clarification before publishing |
| Zero TEU in CONTAINERS | 4,975 (27.6% of containers) | Limits ocean container volume analysis |
| Deactivated carriers still on records | 11,513 (2.0% of records) | Can't cleanly filter active vs inactive carrier performance |
| Missing `VESSEL` in CONTAINERS | 2,763 (15.3%) | Limits ocean carrier-level analysis |
| Missing `VOYAGE` in CONTAINERS | 2,635 (14.6%) | Same as above |
| `VERTICAL = 'N\A'` instead of NULL | 140 customers | Breaks standard null filtering; needs normalization |
| `QUANTITY` in CONTAINERS is a string (e.g., "1 X 40HC") | All records | Can't aggregate container counts without parsing |
| `REVENUE_USD = 0` | 4,431 (0.8% of records) | May skew averages; unclear if valid transactions |

**Negative net revenue breakdown by mode:**

| Mode | Negative Records | Total Negative Value |
|------|-----------------|---------------------|
| Air | 14,226 | -$120.8M |
| Ocean | 7,851 | -$78.9M |
| Ground | 6,494 | -$25.6M |
| Warehouse | 102 | -$7.8M |
| Customs Brokerage | 1,835 | -$1.0M |
| Rail | 166 | -$0.8M |

Air's -$120.8M is the most significant — this could indicate cost corrections, write-offs, or billing adjustments. Until clarified with finance, Air margin figures should be treated as directional rather than definitive.

**My approach:** Call these out, document them, and move on. In a production setting I'd file data quality tickets and work with the source system owners to resolve upstream. The missing delivery date issue in particular needs to be resolved before on-time performance can be reliably reported across all service modes.

---

## What I'd Do Next

**Additional analysis:**
- Carrier-level on-time scorecard — identify which specific carriers are driving Air's 13% late rate
- YoY growth rates by vertical — which segments are growing vs shrinking post-boom
- Late shipment root cause by trade lane — is the Ocean 74% on-time concentrated in specific origin/destination pairs or spread evenly?
- Deeper customer analysis — segment the low-margin high-revenue customers (like Deadly Really Vital Hen) to understand if there's a pricing or service mix issue

**Data modeling — going from exploration to production:**
- Build a proper dimensional model in dbt: `dim_customer`, `dim_carrier`, `dim_geography`, `fct_shipments`
- Staging models to handle known DQ issues: strip `**Deactivated**` prefix, normalize `VERTICAL = 'N\A'` → NULL, parse `QUANTITY` string into container count and type
- Add dbt tests: `not_null`, `accepted_values`, `relationships` — these would have caught the N\A vertical and deactivated carrier issues at ingestion
- Validate negative `NET_REVENUE_USD` records with finance before publishing any margin metrics to leadership
- Add a `transit_days` derived field (DELIVERY_DATE - ORDER_DATE) for service level analysis

**Publishing & governance:**
- Connect Power BI or Tableau directly to Snowflake semantic layer
- CEO-level KPI dashboard: revenue trend, margin by mode, on-time by mode — with drill-through to vertical, trade lane, and carrier
- Row-level security so regional managers only see their geography
- Daily refresh with alerting if Air on-time % drops below threshold
- Resolve missing `DELIVERY_DATE` upstream — 20% of records is too high to produce reliable on-time reporting at scale
