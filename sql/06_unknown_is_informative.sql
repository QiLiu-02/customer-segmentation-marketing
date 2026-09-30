-- Does "unknown" behave like a random, meaningless label, or does it carry real signal?
-- For each of the four columns that use "unknown", compare the subscription rate of the
-- "unknown" rows against the overall average. A rate close to average suggests "unknown" is just
-- noise; a rate far from average suggests it is informative and should be kept as its own category
-- rather than guessed away.
WITH overall AS (
    SELECT AVG(CASE WHEN y = 'yes' THEN 1.0 ELSE 0 END) AS overall_rate FROM bank_raw
)
SELECT 'job' AS column_name,
       COUNT(*) FILTER (WHERE job = 'unknown')                                          AS n_unknown,
       ROUND(100.0 * AVG(CASE WHEN y = 'yes' THEN 1.0 ELSE 0 END) FILTER (WHERE job = 'unknown'), 2) AS unknown_subscribe_rate_pct,
       ROUND(100.0 * (SELECT overall_rate FROM overall), 2)                             AS overall_subscribe_rate_pct
FROM bank_raw
UNION ALL
SELECT 'education',
       COUNT(*) FILTER (WHERE education = 'unknown'),
       ROUND(100.0 * AVG(CASE WHEN y = 'yes' THEN 1.0 ELSE 0 END) FILTER (WHERE education = 'unknown'), 2),
       ROUND(100.0 * (SELECT overall_rate FROM overall), 2)
FROM bank_raw
UNION ALL
SELECT 'contact',
       COUNT(*) FILTER (WHERE contact = 'unknown'),
       ROUND(100.0 * AVG(CASE WHEN y = 'yes' THEN 1.0 ELSE 0 END) FILTER (WHERE contact = 'unknown'), 2),
       ROUND(100.0 * (SELECT overall_rate FROM overall), 2)
FROM bank_raw
UNION ALL
SELECT 'poutcome',
       COUNT(*) FILTER (WHERE poutcome = 'unknown'),
       ROUND(100.0 * AVG(CASE WHEN y = 'yes' THEN 1.0 ELSE 0 END) FILTER (WHERE poutcome = 'unknown'), 2),
       ROUND(100.0 * (SELECT overall_rate FROM overall), 2)
FROM bank_raw
ORDER BY column_name;
