# EDGAR parser target ladder

The formats below can be used as increasingly difficult real-data parser exercises without inventing toy records.

## 1. Ticker reference JSON

Input: `company_tickers.json`.

Minimum useful result:

- decode records;
- normalize CIK to ten digits;
- lookup ticker → CIK and CIK → company name;
- print one match.

Pressure: ordinary JSON arrays/objects and integer/string normalization.

## 2. Submissions JSON

Input: `data.sec.gov/submissions/CIK##########.json`.

Minimum useful result:

- decode company metadata;
- zip the parallel recent-filing arrays into filing records;
- filter by form type;
- print accession number, filed date, report date, and primary document.

Pressure: column-oriented JSON and optional historical continuation files.

## 3. EDGAR `.idx`

Input: one daily `master.YYYYMMDD.idx`.

Minimum useful result:

- skip preamble/header lines;
- recover CIK, company name, form, filing date, and archive path;
- filter one form type;
- print the resulting archive paths.

Pressure: old-fashioned text layout, headings, separators, variable-width company names, and line-oriented streaming.

## 4. Directory `index.json` and `index.xml`

Input: the JSON and XML representations of the same EDGAR archive directory.

Minimum useful result:

- recover file names, sizes, and modification dates;
- confirm both representations normalize to the same file list.

Pressure: two wire formats representing the same logical data; useful cross-parser oracle.

## 5. Structured-disclosure RSS

Input: `xbrlrss.all.xml` or one historical monthly `xbrlrss-YYYY-MM.xml`.

Minimum useful result:

- enumerate entries;
- recover filer name, CIK, accession number, form, and filing date;
- filter by form;
- follow the filing or XBRL ZIP link.

Pressure: namespaces, RSS structure, repeated entries, URLs, and streaming XML.

## 6. Complete submission text file

Input: one EDGAR accession `.txt` file.

Minimum useful result:

- parse the filing header;
- split all `<DOCUMENT>...</DOCUMENT>` sections;
- recover TYPE, SEQUENCE, FILENAME, DESCRIPTION, and payload;
- print a table of embedded documents;
- optionally write selected payloads to files.

Pressure: SGML-like container syntax around heterogeneous embedded content. This is probably the most interesting non-XBRL target.

## 7. Form XML

Inputs: XML-native filings such as Forms 3/4/5, Form D, N-PORT, N-CEN, and N-MFP.

Minimum useful result should be form-specific rather than a generic DOM dump. Examples:

- Form 4: issuer, reporting owner, transaction date, security title, transaction code, shares, price, acquired/disposed flag;
- Form D: issuer, offering amount, amount sold, investors, exemption, related persons.

Pressure: namespaces, nested records, optional fields, repeated transactions/persons, dates, amounts, and enumerated codes.

The existing `form-d-xml` branch is the dedicated Form D lane.

## 8. Extracted XBRL instance XML

Input: a filing's `*_htm.xml` extracted instance document.

Minimum useful result:

- enumerate facts;
- resolve one fact's `contextRef`;
- resolve `unitRef`;
- distinguish instant from duration periods;
- select one standard concept and print all periods/values.

Pressure: heavy namespace use, cross-references, numeric metadata, dimensions, and very large fact sets.

The existing `xbrl-xml` branch is the dedicated XBRL lane.

## 9. XBRL linkbases and extension schema

Inputs: `.xsd`, `_pre.xml`, `_def.xml`, `_lab.xml`.

Minimum useful result:

- identify extension concepts;
- map concept → human label;
- recover presentation relationships and order;
- recover selected definition/dimensional relationships.

Pressure: XML namespaces, URI fragments, locators/arcs, graph construction, and multiple files acting as one logical document.

## 10. Inline XBRL

Input: primary filing `.htm` carrying `ix:` elements.

Minimum useful result:

- extract one `ix:nonFraction` or `ix:nonNumeric` fact;
- recover its concept, context, unit, scale/sign/format metadata as applicable;
- compare it with the corresponding extracted XBRL instance fact.

Pressure: HTML/XHTML parsing plus XBRL semantics and hidden/visible fact representation.

## 11. Feed tarballs / Oldloads

Input: one daily archive from `Feed/` or `Oldloads/`.

Minimum useful result:

- stream archive members or concatenated submissions;
- recover accession boundaries;
- feed each submission into the complete-submission parser;
- count filings by form.

Pressure: archive/container streaming, large inputs, recovery from malformed or unusual filings, and memory discipline.

## 12. Cross-check against SEC flattened data

After a form/XBRL parser works, select a source filing represented in one of the SEC Data Library flat-file products and compare a handful of normalized fields.

This provides a much stronger acceptance check than comparing only against a hand-written fixture.
