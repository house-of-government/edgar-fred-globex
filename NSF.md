# NSF awards

The U.S. National Science Foundation Award Search is useful for a different question from “what funding opportunities exist?”: **what did NSF actually fund, who got the money, through which program, for how much, and to do what?**

That makes the award corpus useful both as structured-data material and as evidence for thinking ahead about a research career. It is possible to inspect fields, institutions, investigators, programs, award sizes, dates, and abstracts before treating “become a scientist” as if funding somehow appears after graduate school.

## Official sources

- Award Search overview: https://www.nsf.gov/funding/award-search
- NSF developer resources: https://www.nsf.gov/digital/developer
- Award Search API documentation: https://resources.research.gov/common/webapi/awardapisearch-v1.htm
- Data.gov catalog record: https://catalog.data.gov/dataset/nsf-award-search-web-api
- Award downloads: https://www.nsf.gov/awardsearch/download.jsp

The Award Search overview says the searchable database contains NSF-funded projects since 1989. The Data.gov description of the API says its Research.gov award information begins in 2007. Those are not identical coverage claims, so code and analysis should treat coverage as source-specific rather than silently assuming one universal start year.

## Data and reuse

NSF says award data posted on its website, including award abstract text, is in the public domain. Publications and conference proceedings linked from awards can still be copyrighted by their publishers.

The public Award Search exposes award abstracts, not the submitted proposals themselves. NSF describes proposals as confidential intellectual property of the submitting organizations. This corpus can show what was funded and how the public abstract describes it; it is not a corpus of successful full proposals.

## API

The documented endpoints are:

```text
GET https://api.nsf.gov/services/v1/awards.{json|xml}?parameters
GET https://api.nsf.gov/services/v1/awards/{id}.{json|xml}
GET https://api.nsf.gov/services/v1/awards/{id}/projectoutcomes.{json|xml}
```

Searches support free-text/Boolean keywords plus structured fields such as investigator, awardee organization/location, program, dates, program officer, award status, and award number. The API paginates with `rpp` and `offset`; `rpp` is limited to 25 and search display is capped at 3,000 results, so broad corpus work should refine queries or use bulk award downloads instead of pretending pagination is unbounded.

The API documentation currently says `printFields` is no longer functional. The local CLI therefore preserves the raw response rather than claiming server-side projection.

## Command-line search

`bin/nsf-awards` is a standard-library Python wrapper around the public API. It writes raw JSON or XML to stdout so another command can parse, filter, save, or compare it.

Examples:

```sh
# Search title/abstract and related indexed award data.
bin/nsf-awards search 'non-von Neumann'

# Search the whole state before narrowing to the remembered institution.
bin/nsf-awards search '"non-von Neumann"' --state IN

# Narrow the remembered Bloomington/Indiana lead.
bin/nsf-awards search '"non-von Neumann"' \
  --awardee 'Indiana University' \
  --state IN

# Look at what one program/institution has actually received.
bin/nsf-awards search compiler --awardee 'Indiana University'

# Exact award record or public project-outcomes report.
bin/nsf-awards award 1052893
bin/nsf-awards outcomes 1052893

# XML instead of JSON.
bin/nsf-awards search --format xml water

# Show the exact request without making it.
bin/nsf-awards search --print-url water --state MI --active

# Pass a documented API parameter that does not have a convenience flag.
bin/nsf-awards search quantum --param 'progRefCode=7556'
```

`NSF_API_BASE` can override the base URL for testing or a future endpoint move. `NSF_API_TIMEOUT` controls the request timeout in seconds.

The Indiana non-von-Neumann investigation is recorded in [NSF_INDIANA_NON_VON_NEUMANN.md](NSF_INDIANA_NON_VON_NEUMANN.md). It distinguishes exact-phrase search from a broader technical classification and records why current evidence does not justify silently identifying NSF Award 1205518 as a CCA award.

## Questions this corpus can answer

Useful analyses include:

- What work in a field is actually being funded, rather than merely described as important?
- Which NSF programs repeatedly fund that work?
- Which investigators and institutions receive those awards?
- What are typical award sizes and durations for a topic/program?
- What related terms appear in funded abstracts that would not have been obvious from a program title?
- Does a plausible path exist from graduate training to the kinds of funded projects one says one wants to lead?
- How does a field’s funded work change over time?

Those are empirical questions. The award corpus does not prove that a particular graduate program, adviser, or research plan will produce funding, but it gives a much better starting point than treating funding as a problem to discover only after years of training.

## Bulk downloads and frozen samples

Do not assume the bulk-download representation is permanently XML. NSF's Award Search overview still describes zipped XML exports, while the Download Awards metadata reports that NSF converted downloadable award files from XML to JSON in January 2025. Treat the bulk format itself as retrieval-time provenance rather than a timeless interface. The Download Awards page can also temporarily have no export files available.

For large historical work, prefer the official Download Awards page when its exports are available rather than issuing thousands of API calls. For parser and acceptance work, freeze a small number of representative records with exact source URLs, retrieval dates, response format, hashes, and selection reasons. Prefer records with nontrivial abstracts/program metadata and at least one case that exercises project outcomes rather than inventing toy awards.

A frozen API response may be tested offline. Repository CI should not require live access to `api.nsf.gov` merely to prove that a search still returns the same records.
