-- For each segment (from notebook 3): how many customers, how much calling effort they
-- absorbed this campaign, how many subscribed, and — the key efficiency number —
-- how many calls it took, on average, to land one subscriber in that segment.
--
-- efficiency_index = (segment's share of all subscribers gained) / (segment's share of all
-- contacts made). Above 1 means the segment delivered more than its "fair share" of results for
-- the calling effort it received; below 1 means it delivered less. This is how
-- "over-/under-performs relative to how often it was contacted" turns into one comparable number
-- across segments of very different sizes.
WITH per_segment AS (
    SELECT
        s.segment_name,
        COUNT(*)                                              AS n_customers,
        SUM(c.campaign)                                       AS total_contacts,
        SUM(CASE WHEN c.subscribed THEN 1 ELSE 0 END)         AS n_subscribers
    FROM bank_clean c
    JOIN customer_segments s USING (customer_id)
    GROUP BY s.segment_name
)
SELECT
    segment_name,
    n_customers,
    ROUND(100.0 * n_customers / SUM(n_customers) OVER (), 1)      AS pct_of_customers,
    total_contacts,
    ROUND(100.0 * total_contacts / SUM(total_contacts) OVER (), 1) AS pct_of_all_contacts,
    n_subscribers,
    ROUND(100.0 * n_subscribers / SUM(n_subscribers) OVER (), 1)   AS pct_of_all_subscribers,
    ROUND(100.0 * n_subscribers / n_customers, 2)                  AS subscribe_rate_pct,
    ROUND(total_contacts * 1.0 / NULLIF(n_subscribers, 0), 1)      AS contacts_per_subscriber,
    ROUND(
        (100.0 * n_subscribers / SUM(n_subscribers) OVER ())
        / (100.0 * total_contacts / SUM(total_contacts) OVER ()), 2
    )                                                               AS efficiency_index
FROM per_segment
ORDER BY subscribe_rate_pct DESC;
