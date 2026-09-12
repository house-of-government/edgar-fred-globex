# Indiana non-von-Neumann NSF award search

Captured 2026-09-07.

This note records a one-time research result and the evidence used to classify it. It is deliberately **not** a live API oracle. Repository tests should continue to test request construction offline; current NSF search results are evidence to capture, not a condition that CI must re-fetch.

## Result

The remembered Bloomington work is **not the only Indiana NSF-funded work that matches non-von-Neumann architecture in the broader technical sense**.

That statement needs a scope distinction:

- **Literal match** means an NSF award record contains the exact phrase `"non-von Neumann"` (or a chosen spelling variant).
- **Technical match** means the funded work falls into architecture classes NSF itself groups with non-von-Neumann computing, such as near/in-memory computing, brain-inspired or neuromorphic computing, analog computing, or biology/physics-inspired computing.

An exact phrase query is reproducible but is not a semantic census. NSF's own FuSe2 solicitation explicitly places those neighboring approaches in the non-von-Neumann computing-strategy domain.

## Bloomington lead

Thomas Sterling and Maciej Brodowicz's Continuum Computer Architecture (CCA) at Indiana University Bloomington is unquestionably a non-von-Neumann architecture in the technical literature. A 2016 paper is titled *A non von neumann continuum computer architecture for scalability beyond Moore's law* and describes CCA as departing from von-Neumann-derived processing logic.

A separate Indiana University source ties Sterling and Brodowicz to NSF Award **1205518**, `REFT - A Reconfigurable Execution Framework Testbed for data-driven and extreme scale computing`. That is useful funding-lineage evidence, but the source describes REFT, not CCA. Do **not** silently turn 1205518 into "the CCA NSF award" without the award record or another primary source making that connection.

Sources:

- CCA paper DOI: https://doi.org/10.1145/2903150.2903486
- IU ScholarWorks REFT report naming NSF Award 1205518: https://scholarworks.iu.edu/dspace/items/2ab90813-dfb2-47c3-9f52-c6483e48f126
- NSF award lookup shape for 1205518: https://www.nsf.gov/awardsearch/showAward?AWD_ID=1205518

Classification: **CCA = confirmed non-von-Neumann Bloomington work; 1205518 = related NSF funding lineage, not yet proven to be the CCA award.**

## Indiana counterexamples to uniqueness

### NSF Award 2425498 — Purdue University

`FuSe2 Topic 1: Bridging Atomic Layers and Foundation Models: An Indium-Oxide-Based Versatile Neural Computing Platform`

Why it counts as a strong technical match:

- NSF's FuSe2 solicitation explicitly names **non-von Neumann architectures**, including near/in-memory compute, and also names biology/physics-inspired, analog, brain-inspired and neuromorphic computing in the same computing-strategy/technology scope.
- NSF's 2024 FuSe2 award announcement lists the Purdue neural-computing-platform project under Topic 1, Collaborative Research in Domain-Specific Computing.
- Work acknowledging NSF Award 2425498 describes in-memory and brain-inspired hardware directions.

Sources:

- NSF FuSe2 solicitation: https://www.nsf.gov/funding/opportunities/fuse2-future-semiconductors/506141/nsf24-521/solicitation
- NSF FuSe2 award announcement: https://www.nsf.gov/news/nsf-awards-42-4m-new-grants-support-future-semiconductors
- NSF award lookup shape: https://www.nsf.gov/awardsearch/showAward?AWD_ID=2425498

Classification: **strong technical counterexample to "only Indiana award"**. Do not claim that the exact words `non-von Neumann` occur in the award abstract until an exact award record is captured.

### NSF Award 2422333 — University of Notre Dame

`EFRI BEGIN OI: Implantation of Dense Associative Memory through CArdiac muscle cell-based Reprogrammable Bio-Oscillatory Neural Networks`

NSF's own EFRI material identifies award 2422333, the University of Notre Dame, and the project title. NSF's award announcement describes the project as constructing reprogrammable bio-oscillator neural networks using cardiac muscle cells to create a high-density, energy-efficient computing platform.

Sources:

- NSF EFRI webinar award list: https://nsf-gov-resources.nsf.gov/attachments/310178/public/EFRI-BEGIN-OI-webinar-2024-08-30.pdf
- NSF biocomputing award announcement: https://www.nsf.gov/news/nsf-invests-14m-bioengineered-systems-ethical-biocomputing
- NSF award lookup shape: https://www.nsf.gov/awardsearch/showAward?AWD_ID=2422333

Classification: **broader unconventional/biocomputing counterexample**. It is useful for semantic expansion, but Purdue 2425498 is the cleaner counterexample when the question is specifically architecture terminology.

## Reproducible query shapes

The exact-phrase statewide query should be broader than the remembered institution:

```sh
bin/nsf-awards search --print-url '"non-von Neumann"' --state IN --rpp 25
```

The Bloomington/IU narrowing remains useful:

```sh
bin/nsf-awards search --print-url '"non-von Neumann"' \
  --awardee 'Indiana University' \
  --state IN \
  --rpp 25
```

Useful semantic-expansion terms, derived from NSF program language rather than invented as synonyms, include:

```text
non-von Neumann
non von Neumann
neuromorphic
brain-inspired
in-memory computing
near-memory computing
analog computing
bio-computing
biology-inspired computing
memory-centric
```

These searches answer different questions. Record the query, filters, retrieval date, result count, award IDs and source URL whenever a live search is used for analysis.

## Provenance rule for future frozen results

When a live API response is intentionally captured, store it as evidence rather than making CI depend on NSF availability. Record at minimum:

```text
retrieved_at_utc
request_url
response_format
sha256
reported_result_count
captured_award_ids
selection_reason
source_coverage_note
```

Tests may parse and validate a frozen response or validate URL construction. They should not require a successful request to `api.nsf.gov`.
