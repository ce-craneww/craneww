-- ============================================================
-- 04_revenue_by_vertical.sql
-- Revenue and margin by customer industry vertical
-- Joined from FILES → CUSTOMERS
-- ============================================================

SELECT 
    c.VERTICAL,
    COUNT(f.GLOBAL_FILE_ID)                                     AS shipment_count,
    ROUND(SUM(f.REVENUE_USD), 2)                                AS total_revenue,
    ROUND(SUM(f.NET_REVENUE_USD), 2)                            AS total_net_revenue,
    ROUND(SUM(f.NET_REVENUE_USD) / 
          NULLIF(SUM(f.REVENUE_USD), 0) * 100, 1)               AS net_margin_pct,
    ROUND(AVG(f.NET_REVENUE_USD), 2)                            AS avg_net_revenue_per_file
FROM SCREENING_BI.FREIGHT.FILES f
JOIN SCREENING_BI.FREIGHT.CUSTOMERS c 
    ON f.CUSTOMER_ID = c.CUSTOMER_ID
GROUP BY 1
ORDER BY 3 DESC;

-- Data quality note:
-- VERTICAL contains 'N\A' (with backslash) — not a standard NULL.
-- In production, this should be normalized: 
--   UPDATE CUSTOMERS SET VERTICAL = NULL WHERE VERTICAL = 'N\A'
-- or handled in a dbt staging model with a CASE/NULLIF expression.
