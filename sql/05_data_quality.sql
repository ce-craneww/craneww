-- ============================================================
-- 05_data_quality.sql
-- Data quality checks — nulls, anomalies, known issues
-- ============================================================

-- Negative net revenue records
SELECT COUNT(*) AS negative_net_revenue_count
FROM SCREENING_BI.FREIGHT.FILES
WHERE NET_REVENUE_USD < 0;

-- Zero revenue records
SELECT COUNT(*) AS zero_revenue_count
FROM SCREENING_BI.FREIGHT.FILES
WHERE REVENUE_USD = 0;

-- Missing delivery dates
SELECT 
    PRODUCT,
    COUNT(*) AS total,
    COUNT(DELIVERY_DATE) AS has_delivery_date,
    COUNT(*) - COUNT(DELIVERY_DATE) AS missing_delivery_date
FROM SCREENING_BI.FREIGHT.FILES
GROUP BY 1
ORDER BY 4 DESC;

-- Deactivated carriers still appearing on records
SELECT COUNT(*) AS deactivated_carrier_records
FROM SCREENING_BI.FREIGHT.FILES
WHERE CARRIERNAME LIKE '%**Deactivated**%';

-- N\A vertical customers
SELECT COUNT(*) AS na_vertical_customers
FROM SCREENING_BI.FREIGHT.CUSTOMERS
WHERE VERTICAL = 'N\\A';

-- Container records with null vessel
SELECT COUNT(*) AS null_vessel_count
FROM SCREENING_BI.FREIGHT.CONTAINERS
WHERE VESSEL IS NULL OR TRIM(VESSEL) = '';

-- Files with missing origin or destination
SELECT
    COUNT(*) AS total,
    COUNT(CASE WHEN ORIGIN_COUNTRY IS NULL THEN 1 END)      AS missing_origin_country,
    COUNT(CASE WHEN DESTINATION_COUNTRY IS NULL THEN 1 END) AS missing_dest_country
FROM SCREENING_BI.FREIGHT.FILES;
