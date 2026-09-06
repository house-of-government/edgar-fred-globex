# Joint Committee on Taxation

The Joint Committee on Taxation (JCT) is a particularly useful economics/tax-policy source because it publishes congressional tax analysis and maintains a public Publications XML archive.

Official XML archive:

https://www.jct.gov/publications-xml/

The archive is organized by Congress and currently includes the 119th Congress as well as many earlier Congresses.

## Why it belongs here

JCT material is closer to the policy-analysis questions that motivated this repository than a generic XML corpus. Relevant concepts include:

- estimated revenue effects;
- tax provisions;
- income/payroll taxes;
- excise taxes;
- legislation and proposals;
- years and dollar amounts;
- distributional/revenue tables;
- methodological descriptions of tax estimates.

## XML/control-flow possibilities

Depending on the structure of a selected XML publication/feed entry:

- iterate over publications from one Congress;
- branch by publication/document type;
- select estimated-revenue material;
- filter by year or legislation;
- collect titles/dates/document identifiers;
- later connect publication metadata to tables or PDF/HTML source material.

This is a good place to keep notes on JCT models and methodology too, including when a document discusses behavioral, macroeconomic, or general-equilibrium effects. Those methodological claims should be tied to the exact JCT document rather than generalized from the archive itself.

## Next source-recovery task

Locate a representative current JCT XML record and preserve it or a small excerpt as a concrete parser specimen, with its exact source URL and document identifier. Prefer something containing estimated revenue effects or other numeric tax-policy material rather than arbitrary metadata.
