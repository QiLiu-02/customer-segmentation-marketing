-- Subscription rate by job type: which occupations respond to this campaign, and how big
-- is each group? A high rate on a tiny group is a different finding from a high rate on a large one.
SELECT
    job,
    COUNT(*)                                                       AS n_customers,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2)             AS pct_of_all_customers,
    ROUND(100.0 * AVG(CASE WHEN subscribed THEN 1.0 ELSE 0 END), 2) AS subscribe_rate_pct
FROM bank_clean
GROUP BY job
ORDER BY subscribe_rate_pct DESC;
