# S&P Global

S&P Global belongs here because some of its economic-data delivery products explicitly support XML, but access is commercial.

## IDDS

S&P Global's Internet Data Delivery System (IDDS) is described as a tailored data-feed service that can deliver updates in CSV or XML format. The economic metadata can include:

- economic concept;
- geography;
- source;
- frequency.

S&P says updates can contain only changed data and can be scheduled.

Official descriptions:

https://www.spglobal.com/market-intelligence/en/solutions/products/economic-analytics-historical-data

https://www.spglobal.com/market-intelligence/en/solutions/products/economic-forecast-monitor

## Subject matter

S&P's US economic data product describes areas including:

- consumer prices and expenditures;
- demographics;
- flow of funds;
- industrial output/productivity;
- international trade and balance of payments;
- employment;
- manufacturing/mining/construction;
- money and banking;
- national accounts;
- price indexes;
- wholesale and retail trade.

That vocabulary makes the XML potentially much more intelligible than arbitrary scientific XML.

## Control-flow possibilities

If sample/licensed XML is available:

- loop through series updates;
- branch by geography or economic concept;
- distinguish actual/forecast values if represented;
- select a frequency;
- process only changed observations;
- compare revisions or successive updates.

## Caveat

Do not assume public anonymous access to the underlying XML feed. Treat the public product pages as documentation of the format/capability and keep any licensed feed material subject to its license.
