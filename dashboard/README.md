# Dashboard: Worth The Call

**Live link:** https://claude.ai/artifact/8NixYHvrTiJhYWaf2BjFmo

![Dashboard screenshot](screenshot.jpg)

A published Tableau Public dashboard was the original goal here. Instead, this is a
self-contained, interactive HTML dashboard, built directly from the same numbers Phase 4
produced. It shows the same three required things — segment sizes, response rate by segment, and
a filter (month and contact type, both included) — plus an "effort vs. results" chart and a
segment profile table that Tableau's own spec didn't ask for but the story benefits from.

## Why not Tableau

Tableau Public needs either a desktop install or a browser-based "web authoring" flow, both of
which are manual, click-by-click GUI work that has to be done by a person, not scripted. After
trying that path, the decision was to build an equivalent dashboard directly instead — same
underlying data, same required elements, fully interactive, with no account, install, or
publishing step needed on either end.

## Files here

- **`worth_the_call.html`** — the dashboard itself. A single self-contained HTML file: open it in
  any browser and it runs, no server or build step required. This is also what's published at the
  live link above.
- **`bank_marketing_dashboard_data.csv`** — the flat, denormalized export (45,211 rows) built by
  `notebooks/05_dashboard_prep.ipynb`. The dashboard's own data is embedded directly in the HTML
  (as a compact month × contact-type × segment summary, computed from this same export), so this
  CSV isn't loaded by the page at runtime — it's kept here as the traceable source of that
  aggregate and as the file a different tool (Tableau included, if picked up later) would read.
- **`segment_month_contact_crosstab.json`** — the exact aggregate embedded in the dashboard
  (segment × month × contact type, with customer counts, subscriber counts and total contacts per
  combination). Regenerating it and re-embedding it in the HTML is how the dashboard would be
  updated if the underlying analysis changes.

## What the dashboard shows

- **Three KPI tiles**: customers in the current filtered view, the response rate for that view,
  and how many times more likely the best segment is to convert than the average.
- **Segment sizes** and **response rate by segment**, both re-sorted and re-drawn live as the
  filters change, with the "Warm: Past Success" segment highlighted throughout as the segment the
  headline finding is about.
- **Effort vs. results**: each segment's share of all calls made, next to its share of all
  subscribers gained — the chart that makes "large but low-yield" and "small but highly
  responsive" visible at a glance.
- **A profile table** (age, balance, existing loans, education, contact-data quality) for
  demographic and financial context, held constant regardless of the filters, matching how it's
  described in the notebooks.
- **Filters**: month and contact type, either usable alone or together, updating every chart and
  KPI at once from the same underlying slice of the data.

## Regenerating it

If the underlying numbers change (a rerun of notebooks 3 or 4 with different clustering choices,
for instance):

1. Run `notebooks/05_dashboard_prep.ipynb` to rebuild `bank_marketing_dashboard_data.csv`.
2. Recompute the month × contact-type × segment aggregate from that export (the same query used to
   build `segment_month_contact_crosstab.json`) and re-embed it as the `CROSSTAB` constant near the
   top of the `<script>` block in `worth_the_call.html`.
3. Update the `PROFILE` constant in the same script block if the segment profile numbers changed.
4. Open the file locally to confirm it still renders correctly before treating it as done.
