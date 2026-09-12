# Frozen fixtures and source links

This directory keeps parser inputs separate from parser implementations. A fixture is either:

- an exact frozen upstream file whose redistribution basis is recorded here; or
- a link-only source when no sufficiently clear redistribution permission has been established.

Do not replace a frozen source fixture with a hand-edited simplification. If a smaller synthetic case is useful later, keep it separately and label it synthetic.

## Mirrored here

### EDGAR XBRL

`edgar/apple-2026-07-30-8-k/aapl-20260730_htm.xml`

A real extracted XBRL instance from Apple Inc. accession `0000320193-26-000018`. It is small enough to audit but nontrivial: eight contexts, an explicit XBRL dimension, one common-stock member, six debt-security members, repeated facts, namespaces, and a schema reference.

SHA-256: `7856aa40e21749ba08f764d9954c62258f2df7f3b804964933d69972c15078fd`

See `edgar/apple-2026-07-30-8-k/PROVENANCE.md`.

### Generic SBE schema

`sbe/aeron-example/example-schema.xml` plus `common-types.xml`

The upstream SBE example is deliberately more useful than a one-message toy. It covers XInclude, primitive types, composites, enums, a bit set, constant fields, nested repeating groups, variable-length ASCII/UTF-8 data, and template/message IDs.

SHA-256:

- `example-schema.xml`: `ebb4959faea556560b78f58f17c8fc904a603b7a27e0ad3548ca472f1c73571f`
- `common-types.xml`: `6f34b3ad848b99224824b08b81f2d7fdb5aaeefcbac5b93015bf689ce59f329f`

See `sbe/aeron-example/PROVENANCE.md`. The Apache License 2.0 text is preserved beside the copied files.

## Link-only and pending-capture sources

See `links/README.md`. This includes FRED XML, Nasdaq ITCH, CME MDP 3.0, FIX, CRSP, S&P Global XML, SEC MIDAS, and JCT XML.

The distinction matters: public accessibility is not by itself a redistribution license.
