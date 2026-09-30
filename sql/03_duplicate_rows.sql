-- Are any rows fully identical? There's no customer ID in this file, so a duplicate row would be
-- two contacts with the exact same values in all 17 columns.
SELECT COUNT(*) AS n_duplicate_rows
FROM (
    SELECT age, job, marital, education, "default", balance, housing, loan, contact, day, month,
           duration, campaign, pdays, previous, poutcome, y
    FROM bank_raw
    GROUP BY ALL
    HAVING COUNT(*) > 1
);
