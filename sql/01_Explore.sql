-- ============================================================
-- 01_explore.sql
-- Initial data exploration — table counts, date ranges, modes
-- ============================================================

-- Table row counts
SHOW TABLES IN SCHEMA SCREENING_BI.FREIGHT;

-- Date range and total shipments
SELECT 
    MIN(ORDER_DATE) AS earliest_order,
    MAX(ORDER_DATE) AS latest_order,
    COUNT(*)        AS total_files
FROM SCREENING_BI.FREIGHT.FILES;

-- Sample each table
SELECT * FROM SCREENING_BI.FREIGHT.FILES       LIMIT 100;
SELECT * FROM SCREENING_BI.FREIGHT.CUSTOMERS   LIMIT 100;
SELECT * FROM SCREENING_BI.FREIGHT.CONTAINERS  LIMIT 100;

-- Distinct product/service modes
SELECT PRODUCT, COUNT(*) AS cnt
FROM SCREENING_BI.FREIGHT.FILES
GROUP BY 1
ORDER BY 2 DESC;

-- Distinct customer verticals (note: N\A is a data quality issue)
SELECT VERTICAL, COUNT(*) AS customer_count
FROM SCREENING_BI.FREIGHT.CUSTOMERS
GROUP BY 1
ORDER BY 2 DESC;
