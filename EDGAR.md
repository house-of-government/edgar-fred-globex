# EDGAR

SEC EDGAR is one of the strongest parser targets in this notebook because one public system exposes JSON, XML, RSS, SGML-like text containers, fixed-column indexes, XBRL, Inline XBRL, ZIP/tar archives, and flattened tabular extracts.

See:

- [EDGAR_ENDPOINTS.txt](EDGAR_ENDPOINTS.txt) — plain endpoint/path inventory;
- [EDGAR_FEEDS.md](EDGAR_FEEDS.md) — public data surfaces and format notes;
- [EDGAR_PARSING_TARGETS.md](EDGAR_PARSING_TARGETS.md) — parser difficulty ladder and concrete acceptance targets.

The existing `xbrl-xml` branch remains the focused XBRL-instance lane and `form-d-xml` remains the focused Form D XML lane. This `edgar-feeds` branch is the broader retrieval/container-format inventory.

## What is actually there

Modern EDGAR filings commonly use Inline XBRL in the filing document and expose related data files separately. A filing can include:

- an extracted XBRL instance document (`*_htm.xml`);
- an XBRL taxonomy extension schema (`.xsd`);
- definition linkbase XML (`*_def.xml`);
- label linkbase XML (`*_lab.xml`);
- presentation linkbase XML (`*_pre.xml`);
- `FilingSummary.xml` and `MetaLinks.json` in many rendered XBRL directories;
- a complete submission `.txt` containing the filing header and embedded documents;
- directory metadata in HTML, XML, and JSON.

Example SEC filing index showing common Inline XBRL and extracted data files:

https://www.sec.gov/Archives/edgar/data/704440/000116169726000200/0001161697-26-000200-index.htm

## Why it is interesting for parsing and control flow

The same source gives increasingly difficult real inputs:

- ticker/CIK lookup JSON;
- filer submissions JSON with parallel filing arrays;
- daily and quarterly `.idx` files;
- directory `index.json` / `index.xml`;
- structured-disclosure RSS XML;
- complete submission text containing multiple `<DOCUMENT>` payloads;
- XML-native forms such as Forms 3/4/5 and Form D;
- XBRL instance XML and linkbases;
- Inline XBRL embedded in XHTML;
- daily feed tarballs and concatenated oldload files.

The XBRL instance data itself gives natural loops and branches:

- iterate over facts;
- branch on element/concept name;
- inspect `contextRef`, `unitRef`, and numeric metadata;
- distinguish periods or entities;
- parse integer/decimal values;
- select revenue, assets, liabilities, income, shares, etc.;
- later follow presentation/definition relationships.

## Candidate experiments

- Parse one daily `master.YYYYMMDD.idx` and print all filings of one form.
- Decode one filer submissions JSON file and normalize its parallel arrays into records.
- Parse one RSS feed and follow its filing/XBRL links.
- Split one complete submission text file into embedded documents.
- Parse a Form 4 transaction or Form D offering.
- Print every monetary XBRL fact for one reporting context.
- Separate USD facts from share counts.
- Find one named concept such as revenue or assets and print all periods.
- Compare an Inline XBRL fact with the corresponding extracted instance fact.
- Compare parsed source values with the SEC's flattened derived data sets.

Do not start by attempting all EDGAR or XBRL semantics. Each individual surface is already large enough to exercise useful parser behavior.

## Official references

- SEC EDGAR APIs: https://www.sec.gov/search-filings/edgar-application-programming-interfaces
- Accessing EDGAR data: https://www.sec.gov/search-filings/edgar-search-assistance/accessing-edgar-data
- SEC developer resources: https://www.sec.gov/about/developer-resources
- Structured-disclosure RSS: https://www.sec.gov/data-research/structured-data/structured-disclosure-rss-feeds
- SEC Data Library: https://www.sec.gov/data-research/sec-markets-data
