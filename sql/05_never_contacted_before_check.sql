-- pdays = -1 is documented as "not previously contacted". This checks that it lines up exactly
-- with previous = 0 (no prior contacts) and with poutcome = 'unknown' (no prior outcome to report),
-- which would confirm these three columns are telling one consistent story, not three separate
-- and possibly conflicting ones.
SELECT
    (pdays = -1)                                    AS never_contacted_before,
    COUNT(*)                                        AS n_customers,
    MIN(previous)                                   AS min_previous,
    MAX(previous)                                   AS max_previous,
    COUNT(*) FILTER (WHERE poutcome = 'unknown')    AS n_poutcome_unknown
FROM bank_raw
GROUP BY 1
ORDER BY 1;
