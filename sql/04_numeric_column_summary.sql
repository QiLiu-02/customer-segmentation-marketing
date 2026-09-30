-- Range and typical value of every numeric column, so we can spot anything impossible
-- (like Project 1's age = 0) before trusting these columns downstream.
-- quantile_cont(col, 0.5) is the median; 0.01 and 0.99 mark the extreme 1% at each end.
SELECT 'age' AS column_name, MIN(age) AS min_value, quantile_cont(age, 0.5) AS median_value,
       quantile_cont(age, 0.99) AS p99_value, MAX(age) AS max_value
FROM bank_raw
UNION ALL
SELECT 'balance', MIN(balance), quantile_cont(balance, 0.5), quantile_cont(balance, 0.99), MAX(balance)
FROM bank_raw
UNION ALL
SELECT 'campaign', MIN(campaign), quantile_cont(campaign, 0.5), quantile_cont(campaign, 0.99), MAX(campaign)
FROM bank_raw
UNION ALL
SELECT 'pdays', MIN(pdays), quantile_cont(pdays, 0.5), quantile_cont(pdays, 0.99), MAX(pdays)
FROM bank_raw
UNION ALL
SELECT 'previous', MIN(previous), quantile_cont(previous, 0.5), quantile_cont(previous, 0.99), MAX(previous)
FROM bank_raw
UNION ALL
SELECT 'duration (excluded from modeling, shown for completeness only)',
       MIN(duration), quantile_cont(duration, 0.5), quantile_cont(duration, 0.99), MAX(duration)
FROM bank_raw;
