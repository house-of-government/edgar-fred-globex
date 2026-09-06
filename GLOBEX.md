# CME Globex

CME Globex is the most interesting protocol-oriented source here because the XML is not the market data itself: XML schema files describe binary SBE messages.

## SBE relationship

CME uses Simple Binary Encoding (SBE) for market-data and order-entry protocols. CME notices refer to downloadable `.xml` SBE schema/configuration files and to schema-version changes.

Examples from CME:

- Streamlined SBE was introduced to align market data with MDP 3.0 encoding; CME explicitly referred to a production `config.xml` schema file.
- CME Benchmark Administration notices identify concrete schema files such as `svstreammktdata_v3.xml`.
- CME materials describe iLink 3 as FIX Binary Order Entry using SBE, with XML schema/templates analogous to MDP 3.

Official examples:

https://www.cmegroup.com/notices/electronic-trading/2016/06/20160620.html

https://www.cmegroup.com/notices/electronic-trading/2024/04/20240401.html

## Why this maps naturally to control flow

An SBE schema naturally suggests compiler/runtime exercises such as:

- loop over message templates;
- inspect a template ID;
- dispatch by template ID;
- loop over fields;
- distinguish ordinary fields, composites, enums/sets, and repeating groups;
- branch on optional/presence information;
- handle schema versions or extensions;
- eventually turn schema descriptions into binary decoding tables.

This is therefore different from EDGAR/FRED:

- EDGAR/FRED: parse XML **data**.
- Globex: parse XML **describing a binary protocol**, then use the description to drive decoding/dispatch.

That second stage is especially relevant to jump-table/multiway-dispatch experiments, but it should be developed with the user actively involved rather than collapsed into a minimal compiler acceptance test.

## Candidate progression

1. Read an SBE XML schema and list message/template names and IDs.
2. For each message, count fields and repeating groups.
3. Dispatch a small set of template IDs to message names.
4. Generate or hand-build a tiny decoder for one selected template.
5. Only later attempt real binary packet decoding.

## Caveat

CME schema locations and versions change over time, and some files are distributed through CME FTP/SFTP environments. Preserve exact schema versions when experiments depend on them.
