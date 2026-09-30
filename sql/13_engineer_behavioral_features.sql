-- Turn three raw columns (pdays, campaign, previous, poutcome) into the recency / frequency /
-- prior-outcome features that will actually feed the clustering in notebook 3. Everything else
-- from bank_clean passes through unchanged, so this one table can be used both to cluster on
-- (the new columns) and to profile the resulting segments afterward (the original columns).
--
--  1. recency_days: pdays, but with -1 ("never contacted before") replaced by 999 — a value
--     worse than any real gap (the longest real gap is 871 days). Left as -1, a clustering
--     algorithm reading distances between numbers would place "never contacted" *next to* "just
--     contacted", which is the opposite of what it means. 999 puts "never contacted" at the far
--     end of the recency scale, where it belongs.
--  2. campaign_capped / previous_capped: both columns have a long tail of rare, extreme values
--     (campaign up to 63 contacts, previous up to 275). Capping at 10 affects 2.6% and 0.7% of
--     customers respectively, and stops a handful of extreme rows from dominating the distance
--     calculations K-means relies on.
--  3. poutcome_failure / poutcome_other / poutcome_success: one boolean column per outcome,
--     except 'unknown' (mostly "never contacted before" — see notebook 1, Section 5), which is
--     left as the reference case where all three are 0. This is the same one-hot pattern used
--     for utilization bands in the credit-risk project.
CREATE OR REPLACE TABLE bank_features AS
SELECT
    *,
    CASE WHEN pdays = -1 THEN 999 ELSE pdays END   AS recency_days,
    LEAST(campaign, 10)                            AS campaign_capped,
    LEAST(previous, 10)                            AS previous_capped,
    CASE WHEN poutcome = 'failure' THEN 1 ELSE 0 END AS poutcome_failure,
    CASE WHEN poutcome = 'other'   THEN 1 ELSE 0 END AS poutcome_other,
    CASE WHEN poutcome = 'success' THEN 1 ELSE 0 END AS poutcome_success
FROM bank_clean;
