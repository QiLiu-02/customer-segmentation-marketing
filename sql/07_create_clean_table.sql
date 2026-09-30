-- Build bank_clean from bank_raw, applying the decisions from this phase:
--
--  1. "unknown" in job, education, contact and poutcome is kept exactly as it is (see
--     06_unknown_is_informative.sql): for contact and poutcome it is a real, meaningful state
--     ("we don't have a working number on file" / "this customer was never contacted before"),
--     and for job and education it is rare enough, and close enough to the average subscription
--     rate, that guessing a replacement would only invent data. No imputation.
--  2. yes/no text columns become plain boolean flags, and are renamed to say what they mean
--     without needing the data dictionary open next to them.
--  3. contacted_before is added so "pdays = -1" (a numeric placeholder) doesn't have to be
--     remembered as meaning "never contacted" every time pdays is used.
--  4. duration is left out entirely. It is only known after a call ends, so it cannot be used to
--     decide who to call — see data/README.md. It stays queryable in bank_raw for anyone who
--     wants it for a clearly-labeled, after-the-fact, descriptive footnote only.
--  5. customer_id is a row number, standing in for the primary key this file doesn't ship with.
CREATE OR REPLACE TABLE bank_clean AS
SELECT
    ROW_NUMBER() OVER ()                    AS customer_id,
    age,
    job,
    marital,
    education,
    ("default" = 'yes')                     AS credit_in_default,
    balance,
    (housing = 'yes')                       AS has_housing_loan,
    (loan = 'yes')                          AS has_personal_loan,
    contact,
    day,
    month,
    campaign,
    pdays,
    (pdays != -1)                           AS contacted_before,
    previous,
    poutcome,
    (y = 'yes')                             AS subscribed
FROM bank_raw;
