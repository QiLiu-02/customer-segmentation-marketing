# Which Customers Are Worth Calling?

*A one-page summary of a customer segmentation analysis on 45,211 bank telemarketing contacts.*

## The question

A bank ran a phone campaign selling term deposits to 45,211 customers. Some converted, most
didn't, and every call costs staff time. Before making the next round of calls: which customers
are actually worth calling, and does it matter when or how they're reached?

## What was done

Every customer was grouped into one of four segments, based only on their history with the bank —
how recently they were last contacted, how often, and what happened last time — using an
unsupervised clustering method (K-means) that finds natural groupings without being told the
answer in advance. Demographics and financial details (age, income, existing loans) were checked
afterward, to describe who ended up in each group, not to build the groups themselves; an earlier
attempt to build the groups from demographics directly produced noticeably worse-defined segments,
so engagement history was kept as the sole basis for the split.

## What was found

**One number to remember: customers who said yes to a previous campaign were 7 times more likely
to say yes again (64.7% vs. 9.2%) — yet they received only 1 in 45 of all the calls made.**

| Segment | Share of customers | How often they said yes | What makes them distinct |
|---|---|---|---|
| Past Success | 3% | 65% | Wealthier, less debt, best contact information |
| Past Mixed Outcome | 4% | 17% | Above average, worth calling |
| Past No | 11% | 13% | Above average, worth calling |
| Never Contacted | 82% | 9% | Below average, and the segment with the worst phone-number data |

Two more findings changed the practical advice, not just added color to it:

- **Timing matters, and it isn't an illusion of which customers happened to be called when.**
  March, September, October and December convert 4 to 7 times better than average — and that
  holds true inside every one of the four segments, not just in the overall numbers.
- **"May is a bad month" turned out to be mostly about phone number quality, not the month
  itself.** Over half of May's calls, and 85% of June's, were made on numbers with no reliable
  contact-type record — and those numbers convert far worse regardless of month. Once that's
  accounted for, June performs nearly as well as the best months, and May is close to average.
  Verifying a good number matters more than avoiding May.

## What this means for the next campaign

1. **Call the Past Success segment first, every time there's capacity.** They convert at 65%,
   and every call to them is currently returning far more than its fair share of results.
2. **Prioritize calls in March, September, October and December.**
3. **Get a reliable cellular number before calling the 82% of customers who've never been
   reached before.** Roughly 3 times more of them convert when reached on a real cellular number
   versus one with no usable type on file.
4. **Don't skip May or June — check the number first.** The problem was the data, not the
   calendar.

## What this analysis can't tell us

This describes one bank's past campaign, not a controlled experiment: no customer here was
randomly assigned to be called or not, so "March works better" is a pattern in what happened, not
a guarantee about what would happen if the bank moved more calls there. The dataset also has no
cost or profit figures, so "worth calling" here means "converts well for the effort," not a
guaranteed profit. And the data appears to span several years under repeating month labels with no
year recorded, so a given month could reflect very different economic conditions from one occurrence
to the next. Any of this would be worth testing deliberately before betting a full campaign on it.

*Full method, code, and an interactive dashboard: see the project repository.*
