-- Subscription rate by the outcome of the PREVIOUS marketing campaign for this customer.
-- 'unknown' here mostly means "first-time contact" (see notebook 1, Section 5).
SELECT
    poutcome,
    COUNT(*)                                                        AS n_customers,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2)              AS pct_of_all_customers,
    ROUND(100.0 * AVG(CASE WHEN subscribed THEN 1.0 ELSE 0 END), 2) AS subscribe_rate_pct
FROM bank_clean
GROUP BY poutcome
ORDER BY subscribe_rate_pct DESC;
