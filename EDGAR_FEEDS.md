# EDGAR public data surfaces

This branch inventories EDGAR as a parser/data-source target rather than treating it only as XBRL.

## REST JSON

The public `data.sec.gov` APIs require no API key.

- `https://data.sec.gov/submissions/CIK##########.json` — one filer's metadata and filing history. Recent filings are represented with compact column-oriented arrays.
- `https://data.sec.gov/api/xbrl/companyconcept/CIK##########/{taxonomy}/{tag}.json` — one filer and one standard taxonomy concept.
- `https://data.sec.gov/api/xbrl/companyfacts/CIK##########.json` — standard-taxonomy facts for one filer.
- `https://data.sec.gov/api/xbrl/frames/{taxonomy}/{tag}/{unit}/{period}.json` — a comparable fact across reporting entities for a calendar frame.

The SEC says submissions normally update in less than a second after dissemination and XBRL APIs normally update in under a minute, though peak periods can be slower.

## Nightly bulk JSON

For large-scale work the SEC recommends bulk archives rather than repeatedly calling the APIs:

- `companyfacts.zip` — company facts/frame API material;
- `submissions.zip` — public submission histories for all filers.

These are rebuilt nightly.

## Daily and quarterly indexes

EDGAR exposes daily and full/quarterly indexes under `Archives/edgar/daily-index` and `Archives/edgar/full-index`.

Useful parser targets include daily `company`, `form`, `master`, and `crawler` `.idx` files, plus quarterly `company.idx`, `form.idx`, `master.idx`, and `xbrl.idx`.

The classic `.idx` files are plain text with headers and column-oriented records. The same archive directories also expose `index.html`, `index.xml`, and `index.json`, so one directory can be used to compare several representations of related information.

## Complete filing submissions

A filing can be fetched as one complete submission text file under `/Archives/edgar/data/{CIK}/...`.

This is one of the strongest parser targets in EDGAR. A submission contains a filing header plus multiple embedded `<DOCUMENT>` sections. A useful first parser only needs to recover:

- filing/header metadata;
- each `<DOCUMENT>` block;
- `<TYPE>`;
- `<SEQUENCE>`;
- `<FILENAME>`;
- `<DESCRIPTION>`;
- the document payload.

The embedded payload can itself be HTML, XML, XBRL, text, or another filing artifact. The SEC's Public Dissemination Service documentation describes the dissemination and filing-header format.

## Per-filing directories

Post-2000 filings normally have a directory keyed by CIK and accession number without dashes. Directory listings are available as HTML, XML, and JSON.

A filing directory may contain the complete submission `.txt`, primary HTML or Inline XBRL document, exhibits, extracted XBRL instance XML, extension schema `.xsd`, definition/label/presentation linkbases, `FilingSummary.xml`, `MetaLinks.json`, and an `-xbrl.zip` bundle. Not every filing has every file class.

## XBRL and Inline XBRL

The existing `xbrl-xml` branch remains the focused instance-document parser lane.

Useful structures include namespaces and qualified concept names, contexts and periods, units, `contextRef` and `unitRef`, dimensional members, numeric/text facts, extension schemas, and XBRL linkbases.

Inline XBRL embeds facts in XHTML using the `ix:` namespace, so it should be treated as a separate XHTML+XBRL lane rather than assuming ordinary XML-only input.

## Structured-disclosure RSS/XML

The SEC publishes current RSS feeds for US-GAAP/IFRS filings, mutual-fund risk/return filings, Inline XBRL filings, and all XBRL filings. The SEC says these feeds update every ten minutes on weekdays during EDGAR operating hours.

Entries expose company name, accession number, CIK, filing date, form type, filing links, and links to compressed structured-data files.

There is also a monthly historical XML archive beginning in 2005 under `/Archives/edgar/monthly/xbrlrss-YYYY-MM.xml`.

## Feed and oldload archives

- `/Archives/edgar/Feed/` — filing-day tar/gzip dissemination archives.
- `/Archives/edgar/Oldloads/` — concatenated daily public submissions including filing headers.

These are good streaming/archive/container targets after a single-filing parser works.

## CIK and ticker lookup files

The SEC publishes small reference JSON files for ticker/CIK/company associations, ticker/CIK/company/exchange associations, and mutual-fund CIK/series/class/ticker associations. They are easy first JSON fixtures, though the SEC says these associations are not guaranteed complete or accurate.

## Flattened EDGAR-derived data sets

The SEC Data Library republishes many filing families in analysis-friendly flat files. Current EDGAR-derived families include:

- Financial Statement Data Sets;
- Financial Statement and Notes Data Sets;
- Insider Transactions Data Sets from Forms 3, 4, and 5;
- Form 13F Data Sets;
- Form D Data Sets;
- Mutual Fund Prospectus Risk/Return Summary Data Sets;
- Form N-PORT Data Sets;
- Form N-CEN Data Sets;
- Form N-MFP Data Sets;
- Regulation A Data Sets;
- Crowdfunding Offerings Data Sets;
- Business Development Company Data Sets;
- Variable Insurance Product Data Sets;
- Transfer Agent Data Sets;
- Number of EDGAR Filings by Form Type;
- EDGAR Log File Data Sets.

Several are created by extracting XML or XBRL filings and flattening them. That makes them useful as an oracle: parse an original structured filing, then compare selected normalized values against the SEC's derived data.

## Access rules relevant to a CLI

The SEC currently documents a maximum fair-access rate of 10 requests/second and asks automated clients to declare a descriptive `User-Agent` containing organization/contact information. A CLI should do this explicitly.

`data.sec.gov` does not support browser CORS. That does not matter for an ordinary command-line client.

## Official references

- https://www.sec.gov/search-filings/edgar-application-programming-interfaces
- https://www.sec.gov/search-filings/edgar-search-assistance/accessing-edgar-data
- https://www.sec.gov/about/developer-resources
- https://www.sec.gov/data-research/structured-data/structured-disclosure-rss-feeds
- https://www.sec.gov/data-research/sec-markets-data
