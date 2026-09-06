# FRED

FRED is the cleanest economics-first XML source in this notebook.

## API shape

The Federal Reserve Bank of St. Louis FRED API supports XML and JSON. In API v1, XML is the default response format for many endpoints.

Useful endpoints include:

- series metadata;
- series observations;
- categories;
- sources;
- releases;
- recently updated series.

Official API overview:

https://fred.stlouisfed.org/docs/api/fred/overview.html

Series observations documentation:

https://fred.stlouisfed.org/docs/api/fred/series_observations.html

## Why the XML is attractive

A series observation response is essentially a root element followed by many repeated observations with attributes such as date and value. That makes the economic meaning simple while still exercising real iteration and branching.

Natural operations:

- loop over observations;
- parse date and numeric `value` attributes;
- skip missing observations;
- branch before/after a date;
- count increases/decreases;
- compute min/max or changes;
- compare two series after basic parsing exists.

The subject matter can be chosen so the values are immediately intelligible: unemployment, CPI, industrial production, interest rates, wages, money, etc.

## XML-specific details

The v1 API documentation says `file_type=xml` or `json`, with XML as the default. The observations endpoint also supports Excel and zipped CSV, but XML is directly supported rather than reconstructed from another format.

Errors can also arrive as XML, so even failure handling gives a small branch on an `<error>` element and HTTP status.

## Official references

- https://fred.stlouisfed.org/docs/api/fred/
- https://fred.stlouisfed.org/docs/api/fred/series_observations.html
- https://fred.stlouisfed.org/docs/api/fred/errors.html
