-- Subscription rate by the month of the last contact. month_order is included so the result can
-- be re-sorted chronologically (Jan -> Dec) in a chart, while the default ordering below is by
-- rate, to answer "which months work" at a glance.
SELECT
    month,
    CASE month
        WHEN 'jan' THEN 1 WHEN 'feb' THEN 2 WHEN 'mar' THEN 3 WHEN 'apr' THEN 4
        WHEN 'may' THEN 5 WHEN 'jun' THEN 6 WHEN 'jul' THEN 7 WHEN 'aug' THEN 8
        WHEN 'sep' THEN 9 WHEN 'oct' THEN 10 WHEN 'nov' THEN 11 WHEN 'dec' THEN 12
    END                                                              AS month_order,
    COUNT(*)                                                         AS n_customers,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2)               AS pct_of_all_customers,
    ROUND(100.0 * AVG(CASE WHEN subscribed THEN 1.0 ELSE 0 END), 2)  AS subscribe_rate_pct
FROM bank_clean
GROUP BY month
ORDER BY subscribe_rate_pct DESC;
