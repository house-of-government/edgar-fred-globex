# CRSP

CRSP is useful as a securities-data comparison source, but current documented stock/index delivery is primarily flat-file oriented rather than XML.

## Current documented formats

CRSP's US Stock & Indexes flat-file guide describes files distributed for:

- SAS (`.sas7bdat`);
- ASCII (`.dat`);
- R (`.rds`).

The guide also documents SQL/R-facing data categories and types.

Official guide:

https://www.crsp.org/wp-content/uploads/guides/CRSP_US_Stock_%26_Indexes_Database_Guide_Flat_File_Format_1.0.pdf

## Data classes

Examples include:

- daily and monthly returns/time series;
- delisting information;
- distributions;
- name history;
- shares history;
- index/portfolio membership;
- index time series.

## Why it still belongs here

The data are economically meaningful and give useful later exercises in:

- row iteration;
- date filtering;
- missing-value handling;
- security identifiers and name histories;
- delisting branches;
- return aggregation;
- membership changes.

But it should not be forced into the XML role. If the immediate experiment is an XML parser plus Thumb branching/looping, EDGAR, FRED, and Globex SBE schemas are more natural sources.

## Access caveat

CRSP is a licensed/subscription data product. Keep public documentation and any genuinely accessible sample data distinct from licensed datasets.
