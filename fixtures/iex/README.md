# Frozen IEX samples

These files freeze small pieces of IEX's public market-data surface as observed on 2026-09-06.

- `hist_catalog_2026-09-06.csv` is a tiny snapshot of rows from the public HIST download catalog. It is intentionally small; the actual daily captures are roughly 10–16 GB each.
- `sample_pcaps_2026-09-06.tsv` records official sample packet-capture URLs exposed by IEX's market-data resources page.

The DEEP+ packet-capture filenames use `DPLS`, while the product/specification is presented by IEX as DEEP+. Preserve the source filename rather than renaming the wire artifact.

These fixtures are for provenance/version-selection/parser tests. They should not be treated as a claim that the listed URLs or catalog rows remain current after the snapshot date.

Source pages:

- https://iextrading.com/trading/market-data/
- https://www.iex.io/resources/trading/market-data
