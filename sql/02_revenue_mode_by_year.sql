-- ============================================================
-- 02_revenue_by_mode_year.sql
-- Revenue, net revenue, and margin by product mode and year
-- Core CEO question: how are we doing, and where is profit?
-- ============================================================

SELECT 
    YEAR(ORDER_DATE)                                        AS order_year,
    PRODUCT,
    COUNT(*)                                                AS shipment_count,
    ROUND(SUM(REVENUE_USD), 2)                              AS total_revenue,
    ROUND(SUM(NET_REVENUE_USD), 2)                          AS total_net_revenue,
    ROUND(AVG(NET_REVENUE_USD), 2)                          AS avg_net_revenue,
    ROUND(SUM(NET_REVENUE_USD) / 
          NULLIF(SUM(REVENUE_USD), 0) * 100, 1)             AS net_margin_pct
FROM SCREENING_BI.FREIGHT.FILES
GROUP BY 1, 2
ORDER BY 1, 3 DESC;

-- Key findings:
-- Warehouse: ~83% net margin consistently — highest margin service by far
-- Customs Brokerage: ~34% margin — steady and predictable
-- AIR: highest volume (~216k shipments) but only ~22% margin
-- Ocean margin improved YoY: 17.4% (2021) → 18.9% (2022) → 21.5% (2023)
-- Rail: tiny volume (<200 shipments/yr), volatile margin — low statistical significance
