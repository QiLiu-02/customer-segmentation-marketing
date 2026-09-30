-- This dataset has no blank cells. Instead, four categorical columns use the literal text
-- "unknown" as their own category. This query finds every column that does that and how often,
-- so the cleaning decision in 07_create_clean_table.sql is based on numbers, not a guess.
SELECT 'job' AS column_name,
       COUNT(*) FILTER (WHERE job = 'unknown')       AS n_unknown,
       ROUND(100.0 * COUNT(*) FILTER (WHERE job = 'unknown') / COUNT(*), 2) AS pct_unknown
FROM bank_raw
UNION ALL
SELECT 'education',
       COUNT(*) FILTER (WHERE education = 'unknown'),
       ROUND(100.0 * COUNT(*) FILTER (WHERE education = 'unknown') / COUNT(*), 2)
FROM bank_raw
UNION ALL
SELECT 'contact',
       COUNT(*) FILTER (WHERE contact = 'unknown'),
       ROUND(100.0 * COUNT(*) FILTER (WHERE contact = 'unknown') / COUNT(*), 2)
FROM bank_raw
UNION ALL
SELECT 'poutcome',
       COUNT(*) FILTER (WHERE poutcome = 'unknown'),
       ROUND(100.0 * COUNT(*) FILTER (WHERE poutcome = 'unknown') / COUNT(*), 2)
FROM bank_raw
ORDER BY pct_unknown DESC;
