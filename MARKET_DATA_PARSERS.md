# Market-data parser curriculum for Edriç

This branch collects real market-data wire formats that are more useful for teaching Edriç than invented parser exercises. The goal is not merely to decode bytes: the examples should progress from simple textual messages through binary protocols, schema-driven decoding, sequence handling, and finally limit-order-book reconstruction.

## Keep wire decoding separate from book state

Do not bury the book implementation inside an exchange-specific decoder.

```text
exchange bytes
    ↓
protocol decoder
    ↓
normalized order/book events
    ↓
book
    ↓
quote / depth / spread
```

This lets several unrelated protocols feed one common reducer and makes the state transition logic independently testable.

## Suggested command-line progression

### `fixdump`

Classic FIX `tag=value` messages.

Useful first parser because it teaches:

- byte/string delimiters;
- integer tags;
- length fields;
- checksums;
- optional/repeated fields;
- conversion from loosely typed wire text into typed values.

FIX is a good warm-up, but it is not the endpoint for modern CME binary market data.

### `itchdump`

Nasdaq TotalView-ITCH-style binary messages.

This is probably the best first serious limit-order-book parser because the wire protocol exposes order-level events such as:

- add order;
- execute order;
- cancel/reduce order;
- delete order;
- replace order;
- trades and system events.

It exercises fixed-width integers, message-type dispatch, timestamps, identifiers, prices, quantities, and incremental state.

Prefer captured/sample ITCH files as deterministic acceptance fixtures. A live subscription is not required to teach the parser or book logic.

### `sbedump`

Generic Simple Binary Encoding decoder.

The schema should drive decoding rather than hard-coding one CME message family immediately.

Interesting Edriç exercises include:

- parse the SBE XML schema;
- enumerate message templates and template IDs;
- parse primitive encodings;
- parse composites;
- enums and sets;
- optional/presence values;
- repeating groups;
- schema versions/extensions;
- generate or construct dispatch tables from template IDs.

This connects directly with the existing `GLOBEX.md` schema work.

### `cme-mdp`

CME MDP 3.0 market-data decoding using SBE/FIX Binary conventions.

Important distinction: SBE should not be described simply as "the successor to FIX." CME retained FIX-derived semantics while replacing older FAST/compression-oriented binary machinery with SBE-based encoding.

The MDP exercise should eventually cover:

- packet/message sequencing;
- incremental refreshes;
- snapshots;
- security definitions;
- trades;
- price/quantity decimal representation;
- repeating groups;
- template-ID dispatch;
- gap detection and recovery policy;
- normalization into the common book-event vocabulary.

### `book`

Protocol-independent reducer.

Input: normalized order/book events on stdin.

Output: reconstructed book state on stdout.

Keep this independent of ITCH, CME, or any particular exchange. It should be possible to feed hand-written fixtures directly into `book` without touching a wire decoder.

Candidate normalized operations include:

```text
add
change
cancel
execute
delete
replace
snapshot_begin
snapshot_level
snapshot_end
```

The exact vocabulary can evolve as real protocols expose mismatches; do not force all exchanges into an ontology chosen in advance.

### `quote`

Read reconstructed book state or normalized depth updates and expose derived values such as:

- best bid;
- best offer;
- spread;
- midpoint;
- depth-N;
- aggregate quantity by level.

Keep derivation separate from wire parsing and from the core state reducer.

### `ilink`

Later exercise: CME iLink 3 order entry.

This is deliberately later because it is an order-entry protocol rather than a passive market-data feed. It is still valuable for Edriç because it combines SBE/FIXP-style framing with fixed binary layouts, session state, sequencing, and request/response behavior.

## Why these are good Edriç examples

Together these protocols exercise substantially more than parsing syntax:

- byte order;
- fixed-width signed/unsigned integers;
- explicit field widths;
- decimal scaling;
- enums and tagged alternatives;
- fixed-layout records;
- variable/repeating groups;
- schema-generated decoding;
- multiway dispatch and jump-table opportunities;
- sequence numbers;
- packet gaps;
- state machines;
- incremental state reconstruction;
- deterministic replay;
- stdin/stdout composition between small command-line tools.

## Recommended order

1. FIX text parser.
2. ITCH binary decoder against sample/captured files.
3. Protocol-independent `book` reducer.
4. `quote` derivations.
5. Generic SBE schema parser/decoder.
6. CME MDP 3.0 decoder feeding the same `book` reducer.
7. iLink 3 only after the passive market-data path is solid.

ITCH before CME MDP 3.0 is intentional: it gives a serious binary/order-book problem with less schema and transport machinery in the way.

## CRSP is a different lane

CRSP historical datasets can still be useful parser/data-model examples, but they should not be forced into the live quote/feed role. Historical market data and exchange wire-protocol decoding are related but distinct teaching problems.

## Acceptance-test shape

Prefer reproducible captures and tiny hand-auditable fixtures over requiring live market access.

For each decoder, preserve:

1. exact input bytes or source fixture;
2. expected decoded message;
3. expected normalized event(s);
4. expected book state after replay;
5. exact PASS/FAIL receipt.

That gives Edriç parser/backend work stable artifacts even when the underlying exchange feed is not publicly live.
