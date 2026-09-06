# SEC MIDAS

MIDAS (Market Information Data Analytics System) is an SEC market-structure data system. It is important here because it represents genuinely high-volume order-book/market-event material even though the public derived datasets are not primarily an XML feed.

## What MIDAS collects

The SEC says MIDAS collects roughly 1 billion records per day from proprietary feeds of national equity exchanges, time-stamped to the microsecond. Its data includes:

- posted orders and quotes;
- modifications/cancellations;
- trade executions against orders;
- off-exchange trade executions;
- data on listed stocks/ETPs, plus options and futures.

Official overview:

https://www.sec.gov/securities-topics/market-structure-analytics/midas-market-information-data-analytics-system

## Public derived downloads

The SEC publishes market-structure datasets derived from this material, including:

- metrics by individual security;
- metrics by security and exchange;
- exchange summary metrics;
- quote-life hazards/survivors;
- conditional cancel/trade distributions;
- spread/depth datasets.

As of June 2026, the SEC download page describes individual-security metrics for more than 4,800 securities.

https://www.sec.gov/data-research/market-structure-data

## Why keep it in this repository

MIDAS gives us economically meaningful control-flow problems even if we do not use it for the first XML parser exercise:

- classify trades/orders by venue/security;
- loop over market events;
- branch among cancellation/trade/quote classes;
- count or aggregate by time bucket;
- compare hidden/odd-lot activity;
- reason about data volumes and compact representations.

It is a good bridge from XML-driven experiments to actual market-data processing.

## Format note

Do not label MIDAS itself an XML source without checking the particular dataset/interface being used. The public SEC downloads are packaged derived datasets; EDGAR and FRED are cleaner choices when the goal is specifically XML.
