# Link-only and pending-capture sources

This file records useful sources that are not mirrored in this commit. “Link-only” means no sufficiently clear blanket redistribution permission was established for the data/sample payload. It is deliberately more conservative than “the file can be downloaded.”

| Format/source | Status here | Source/sample link | Documentation / rights note |
| --- | --- | --- | --- |
| FRED XML | link-only | https://fred.stlouisfed.org/docs/api/fred/series_observations.html | https://fred.stlouisfed.org/docs/api/terms_of_use.html — individual series may be third-party/copyrighted; no blanket permission is inferred for freezing API output in this public repository. |
| Nasdaq TotalView-ITCH | link-only | https://www.nasdaqtrader.com/content/technicalSupport/specifications/dataproducts/ITCHFTP.pdf | https://www.nasdaqtrader.com/TraderNews.aspx?id=dtn2014-26 — current historical files are subscriber-oriented. Nasdaq previously posted transition samples publicly, but public availability is not treated here as a redistribution grant. |
| CME MDP 3.0 / CME SBE | link-only | https://www.cmegroup.com/market-data/distributor/market-data-platform.html | https://www.cmegroup.com/market-data/license-data.html — MDP 3.0 is SBE/FIX Binary, while CME separately licenses market-data use/distribution. Schema notices remain useful documentation links without copying CME payloads here. |
| FIX | link-only pending fixture-license choice | https://www.fixtrading.org/standards/ | The protocol is documented publicly, but this repository should copy a concrete third-party FIX sample only after the sample's own redistribution terms are pinned. Synthetic conformance cases can be added separately and labeled synthetic. |
| CRSP | link-only | https://www.crsp.org/wp-content/uploads/guides/CRSP_US_Stock_%26_Indexes_Database_Guide_Flat_File_Format_1.0.pdf | CRSP is a licensed/subscription data product. Keep the public format guide, not licensed rows, in this repository. |
| S&P Global XML/IDDS | link-only | https://www.spglobal.com/market-intelligence/en/solutions/products/economic-analytics-historical-data | https://www.spglobal.com/en/licensing-terms-and-conditions — commercial/licensed feed; do not infer redistribution rights from product documentation. |
| SEC MIDAS-derived datasets | mirror candidate; exact specimen not frozen here | https://www.sec.gov/data-research/market-structure-data | SEC-created public data can generally be reused under the SEC website dissemination policy. Capture an exact small source file/row set with checksum rather than hand-copying a table. |
| JCT Publications XML | mirror candidate; exact specimen not frozen here | https://www.jct.gov/publications-xml/ | Public congressional XML archive. Freeze a specific returned XML document with its Congress/document identifier and checksum before using it as a parser oracle. |

## CME schema-version anchors

Useful official version notices:

- MDP 3.0 core schema version 13 rollout: https://www.cmegroup.com/notices/electronic-trading/2024/12/20241223.html
- Streamlined SBE introduction/config schema notice: https://www.cmegroup.com/notices/electronic-trading/2016/05/20160523.html

These are documentation provenance, not bundled schema files.

## Nasdaq sample-history anchor

Nasdaq documented that one-day transition sample files were placed on a public FTP server for internal testing in 2008:

https://nasdaqtrader.com/TraderNews.aspx?id=nva2008-091

That historical statement is useful provenance, but it does not establish current redistribution permission for copying those files into this repository.
