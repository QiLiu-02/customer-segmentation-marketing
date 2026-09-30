-- How big is the dataset, and how common is a "yes" (the customer subscribed)?
-- This is the first thing to check with any classification-shaped target: if "yes" is rare,
-- later segment-level response rates need enough rows per segment to be trustworthy.
SELECT
    COUNT(*)                                              AS n_contacts,
    COUNT(*) FILTER (WHERE y = 'yes')                     AS n_subscribed,
    ROUND(100.0 * COUNT(*) FILTER (WHERE y = 'yes') / COUNT(*), 2) AS subscribe_rate_pct
FROM bank_raw;
