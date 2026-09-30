# Data

This project uses the **Bank Marketing** dataset from the UCI Machine Learning Repository:
https://archive.ics.uci.edu/dataset/222/bank+marketing

The raw data is **not included in this repo** (file size, and to keep the repo focused on code).
To reproduce the analysis:

1. Download the dataset zip from the link above (or directly: https://archive.ics.uci.edu/static/public/222/bank+marketing.zip). No account or sign-in is required.
2. Inside it is `bank.zip`, which contains `bank-full.csv`. Extract that one file.
3. Place it at `data/bank-full.csv` in this project.

The dataset also ships a smaller `bank.csv` (10% sample, for quick testing) and a separate
`bank-additional.zip` (a newer, larger campaign with extra economic-indicator columns). This
project uses **`bank-full.csv`** only.

## Rows and columns

45,211 contacts from a Portuguese bank's phone marketing campaign selling term deposits, 17 columns.

| Column | Meaning |
|---|---|
| `age` | Age in years |
| `job` | Type of job (12 categories, including `unknown`) |
| `marital` | Marital status: married, single, divorced (divorced includes widowed) |
| `education` | primary, secondary, tertiary, or `unknown` |
| `default` | Has credit in default? yes/no |
| `balance` | Average yearly balance, in euros |
| `housing` | Has a housing loan? yes/no |
| `loan` | Has a personal loan? yes/no |
| `contact` | Contact communication type: cellular, telephone, or `unknown` |
| `day` | Day of the month of the last contact |
| `month` | Month of the last contact |
| `duration` | Duration of the last contact, in seconds. **See the leakage warning below.** |
| `campaign` | Number of contacts performed during this campaign for this client (includes the last contact) |
| `pdays` | Days since the client was last contacted in a previous campaign; **-1 means never contacted before** |
| `previous` | Number of contacts performed before this campaign, for this client |
| `poutcome` | Outcome of the previous campaign: success, failure, other, or `unknown` |
| `y` | **Target.** Did the client subscribe to a term deposit? yes/no |

Source of the definitions: `bank-names.txt`, included in the UCI download.

## A known leakage trap: `duration`

UCI's own documentation flags this, and it is worth repeating here: `duration` (how long the last
call lasted) is only known **after** the call has already happened. A call that goes long is itself
a sign the customer is engaged, so `duration` is a strong predictor of `y` for a reason that has
nothing to do with who to call in the first place. **`duration` is excluded from segmentation and
from anything meant to guide who to contact.** It is fine to look at only for descriptive,
after-the-fact analysis, and only when that is stated explicitly.

## `unknown` is a category, not a missing value marker in the usual sense

Several categorical columns (`job`, `education`, `contact`, `poutcome`) use the literal string
`"unknown"` instead of a blank cell. There are no blank cells anywhere in this file. How to handle
`unknown` is a cleaning decision made explicitly in Phase 1, not something pandas or SQL will
flag automatically.
