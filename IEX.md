# IEX Exchange

IEX belongs here as a market-structure/data-format source. It also preserves a useful contrast between an exceptionally pleasant retired REST API and the exchange's current binary feeds.

## Historical API reference

IEX Cloud exposed a clean REST/JSON interface and is worth preserving as an API-design example, but it is no longer live. IEX Cloud products were retired on 2024-08-31.

Representative historical request shapes:

- `GET https://cloud.iexapis.com/stable/stock/{symbol}/quote?token=...`
- `GET https://cloud.iexapis.com/stable/stock/{symbol}/chart/{range}?token=...`
- `GET https://cloud.iexapis.com/stable/stock/market/batch?symbols=...&types=quote,chart&range=...&token=...`
- `GET https://cloud.iexapis.com/stable/ref-data/symbols?token=...`

The separate older IEX Exchange API, TOPS Viewer, and Stocks App were retired on 2021-11-18.

## Current exchange feeds

Current IEX Exchange market data is a stronger parser target than the retired REST service:

- **TOPS v1.66** — top-of-book quotations plus last sale.
- **DEEP v1.08** — price-aggregated displayed depth plus last sale.
- **DEEP+ v1.02** — order-by-order displayed depth plus last sale.
- Transport for the equities feeds: **IEX-TP v1**.
- **HIST** provides free T+1 historical packet captures, including the most recent twelve months.

Real-time direct feeds require the relevant subscriber paperwork. HIST is the useful public corpus for parser work because it is frozen binary traffic rather than an invented example.

## Parser progression

1. Parse HIST catalog/file metadata.
2. Parse PCAP framing.
3. Parse IEX-TP framing and sequence information.
4. Decode TOPS messages.
5. Decode DEEP messages and reconstruct an aggregated price-level book.
6. Decode DEEP+ messages and reconstruct order-by-order displayed state.
7. Normalize the results to line-oriented text/JSON/CSV for comparison and shell composition.

A particularly useful versioning test is that current specification revisions and historical capture versions are not identical. The decoder should use the version attached to the capture rather than silently assuming the newest layout.

## Frozen samples in this branch

`fixtures/iex/` contains a small frozen catalog snapshot and a manifest of official sample PCAPs. They are deliberately tiny compared with the multi-gigabyte HIST files, but retain exact source/version/date information so parser work can be tied back to real IEX data.

## Official sources

- Market-data products: https://www.iex.io/products/equities/market-data-connectivity
- Specifications and sample PCAPs: https://www.iex.io/resources/trading/market-data
- HIST downloads: https://iextrading.com/trading/market-data/
- IEX Cloud closure reference: https://iexcloud.org/

Snapshot checked: 2026-09-06.
