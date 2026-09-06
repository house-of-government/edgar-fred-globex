# EDGAR

SEC EDGAR is one of the strongest XML targets in this notebook because the XML carries financial facts that are already recognizable.

## What is actually there

Modern EDGAR filings commonly use Inline XBRL in the filing document and expose related data files separately. A filing can include:

- an extracted XBRL instance document (`*_htm.xml`);
- an XBRL taxonomy extension schema (`.xsd`);
- definition linkbase XML (`*_def.xml`);
- label linkbase XML (`*_lab.xml`);
- presentation linkbase XML (`*_pre.xml`).

Example SEC filing index showing all of those file classes:

https://www.sec.gov/Archives/edgar/data/704440/000116169726000200/0001161697-26-000200-index.htm

## Why it is interesting for control flow

The instance data gives natural loops and branches without inventing toy records:

- iterate over facts;
- branch on element/concept name;
- inspect `contextRef`, `unitRef`, and decimals/precision attributes;
- distinguish periods or entities;
- parse integer/decimal values;
- select revenue, assets, liabilities, income, shares, etc.;
- later follow presentation/definition relationships.

This is more interesting than a minimal parser fixture because the conditions have financial meaning.

## Candidate experiments

- Print every monetary fact for one reporting context.
- Separate USD facts from share counts.
- Find one named concept such as revenue or assets and print all periods.
- Walk repeated facts and compute a maximum/minimum.
- Dispatch among a small set of financial concepts.
- Compare presentation-order XML with facts in the extracted instance.

Do not start by attempting all of XBRL semantics. A single real filing can supply plenty of nested XML, namespaces, attributes, repetition, and numeric data.

## Official references

- SEC EDGAR: https://www.sec.gov/edgar
- SEC filing example above, showing Inline XBRL and extracted XML/linkbase files.
