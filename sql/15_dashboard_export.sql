-- One flat, denormalized table for Tableau to read directly, so the dashboard needs no joins of
-- its own. duration is not included (see data/README.md); customer_id lets Tableau count
-- customers precisely regardless of how any field is grouped or filtered. month_order is a plain
-- number alongside the month name, so Tableau can be told to sort months chronologically
-- (Jan -> Dec) instead of alphabetically.
SELECT
    c.customer_id,
    s.segment_name,
    c.age,
    c.job,
    c.marital,
    c.education,
    c.credit_in_default,
    c.balance,
    c.has_housing_loan,
    c.has_personal_loan,
    c.contact,
    c.day,
    c.month,
    CASE c.month
        WHEN 'jan' THEN 1 WHEN 'feb' THEN 2 WHEN 'mar' THEN 3 WHEN 'apr' THEN 4
        WHEN 'may' THEN 5 WHEN 'jun' THEN 6 WHEN 'jul' THEN 7 WHEN 'aug' THEN 8
        WHEN 'sep' THEN 9 WHEN 'oct' THEN 10 WHEN 'nov' THEN 11 WHEN 'dec' THEN 12
    END                                              AS month_order,
    c.campaign,
    c.pdays,
    c.contacted_before,
    c.previous,
    c.poutcome,
    CASE WHEN c.subscribed THEN 'Yes' ELSE 'No' END AS subscribed
FROM bank_clean c
JOIN customer_segments s USING (customer_id);
