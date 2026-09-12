# edgar-fred-globex

Notes and small examples from real financial, economic, tax, research-funding, and market-structure data sources.

The immediate use is to find interesting, understandable structured data for experimenting with parsing, looping, comparisons, conditional branching, and dispatch. This repository is the notebook/data side of that work. It is **not** permission to independently push the ARM Thumb compiler forward; compiler design and acceptance work should be done with the user actively involved.

## Sources

- [EDGAR](EDGAR.md) — SEC filings; Inline XBRL plus extracted XBRL/XML and XML linkbases.
- [FRED](FRED.md) — Federal Reserve Bank of St. Louis economic series; API supports XML directly and defaults to XML in v1.
- [CME Globex](GLOBEX.md) — SBE market-data/order-entry protocols; XML schemas describe binary messages and repeating groups.
- [SEC MIDAS](MIDAS.md) — exchange/order-book derived market-structure datasets; useful for market-data loops and classifications, but public downloads are not chiefly an XML source.
- [CRSP](CRSP.md) — historical securities data; current documented delivery is primarily flat files (ASCII/SAS/R), so useful data but not the first XML target.
- [S&P Global](SP_GLOBAL.md) — commercial economic data; IDDS can deliver XML or CSV feeds.
- [Joint Committee on Taxation](JCT.md) — congressional tax-analysis publications with a public Publications XML archive.
- [NSF awards](NSF.md) — funded research projects; public Award Search API returns JSON/XML and NSF also publishes annual bulk XML. Useful for asking what work actually gets funded, by which programs, investigators, institutions, and award sizes.

## Command-line source access

`bin/nsf-awards` provides a small raw-output wrapper around the NSF Award Search API. It keeps JSON/XML on stdout so the data can feed later parsing and analysis rather than burying the source behind an application-specific database.

## Frozen fixtures

[`fixtures/`](fixtures/) now contains exact parser specimens with source, checksum, documentation, and redistribution provenance. It also keeps a link-only matrix for sources where public availability is not treated as permission to mirror the payload.

Current mirrored specimens:

- EDGAR extracted XBRL: a real Apple 2026-07-30 8-K instance with eight contexts and explicit dimension members.
- Generic SBE: Aeron's pinned Apache-2.0 example schema plus its included common types, covering composites, enums, sets, constants, nested repeating groups, and variable data.

## XML/control-flow interest

A useful progression is not “minimal compiler acceptance tests,” but increasingly interesting real data:

1. FRED observations: repeated elements with dates and numeric values.
2. EDGAR XBRL: namespaces, attributes, contexts, units, financial facts, and linkbases.
3. Globex SBE schema: messages, fields, composites, repeating groups, template IDs, and versioning — XML that naturally describes later binary dispatch.
4. JCT/S&P Global where the subject matter itself suggests economically meaningful filtering and aggregation.
5. NSF award XML: investigators, institutions, programs, dates, amounts, abstracts, and project outcomes — structured data tied directly to the practical question of what scientific work gets funded.

MIDAS and CRSP belong in the same notebook because they are economically/financially interesting comparison sources even when XML is not their natural transport.
