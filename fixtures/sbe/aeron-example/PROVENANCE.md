# Provenance: Aeron SBE example schema

## Frozen upstream revision

- Repository: https://github.com/aeron-io/simple-binary-encoding
- Commit: `ea0caa90c37b3a983f41ef62538eb92b6ea0266b`
- Commit URL: https://github.com/aeron-io/simple-binary-encoding/commit/ea0caa90c37b3a983f41ef62538eb92b6ea0266b

Exact upstream paths at that revision:

- `sbe-samples/src/main/resources/example-schema.xml`
- `sbe-samples/src/main/resources/common-types.xml`

Pinned source links:

- https://github.com/aeron-io/simple-binary-encoding/blob/ea0caa90c37b3a983f41ef62538eb92b6ea0266b/sbe-samples/src/main/resources/example-schema.xml
- https://github.com/aeron-io/simple-binary-encoding/blob/ea0caa90c37b3a983f41ef62538eb92b6ea0266b/sbe-samples/src/main/resources/common-types.xml

SHA-256:

- `example-schema.xml`: `ebb4959faea556560b78f58f17c8fc904a603b7a27e0ad3548ca472f1c73571f`
- `common-types.xml`: `6f34b3ad848b99224824b08b81f2d7fdb5aaeefcbac5b93015bf689ce59f329f`

## Why this fixture

This one schema forces substantially more parser behavior than a minimal SBE record: XInclude, fixed arrays, primitive bounds, composites, nested enum/composite definitions, constant presence, refs, a set, nested repeating groups, and three variable-data fields. `common-types.xml` supplies the message header, repeating-group dimensions, and variable-length encodings required by the main schema.

## Documentation

- FIX Trading Community SBE standard and downloads: https://www.fixtrading.org/standards/sbe/
- Online SBE message-schema documentation: https://www.fixtrading.org/standards/sbe-online/

## Redistribution basis

The Aeron Simple Binary Encoding repository is licensed under Apache License 2.0. These files are copied unmodified from the pinned revision. A copy of Apache License 2.0 is included as `LICENSE` in this directory.

Upstream license:
https://github.com/aeron-io/simple-binary-encoding/blob/ea0caa90c37b3a983f41ef62538eb92b6ea0266b/LICENSE
