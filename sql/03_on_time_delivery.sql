-- ============================================================
-- 03_on_time_delivery.sql
-- On-time delivery performance by product mode
-- Compares DELIVERY_DATE vs REQUESTED_DELIVERY_DATE
-- ============================================================

SELECT
    PRODUCT,
    COUNT(*)                                                        AS total_shipments,
    COUNT(CASE WHEN DELIVERY_DATE IS NOT NULL 
               AND REQUESTED_DELIVERY_DATE IS NOT NULL 
               THEN 1 END)                                          AS has_both_dates,
    COUNT(CASE WHEN DELIVERY_DATE <= REQUESTED_DELIVERY_DATE 
               THEN 1 END)                                          AS on_time,
    COUNT(CASE WHEN DELIVERY_DATE > REQUESTED_DELIVERY_DATE 
