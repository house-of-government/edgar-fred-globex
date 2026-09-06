# Earth-observation parser staging map

This branch is an index. Detailed notes live on isolated format/product branches so each parser boundary can be investigated without pretending the final repository architecture is settled.

## Staged branches

### Lower-level formats

- `geotiff` — existing TIFF/GeoTIFF offset/tag/georeferencing target.
- `hdf5` — existing HDF5 object-graph target.
- `netcdf` — classic-family headers plus the netCDF logical model and netCDF-4/HDF5 composition.
- `hdf4` — legacy tagged-object/data-descriptor format used heavily by older NASA Earth science.
- `hdf-eos` — Grid/Swath/Point Earth-science semantics above HDF4/HDF5.
- `jpeg2000` — JP2 box/container boundary used by Sentinel-2 imagery.
- `ccsds-space-packets` — six-byte primary header, length-framed packet stream and APID dispatch boundary.

### Real public product families

- `sentinel-safe` — directory graph + XML/XSD + JP2 imagery.
- `modis-hdf-eos` — HDF4 + HDF-EOS2 + packed scientific arrays, QA and geolocation.
- `goes-r` — netCDF-4 Level 1b/2+ plus Level 0 netCDF containing opaque CCSDS packet bytes.
- `landsat-c2` — STAC/JSON discovery + MTL/ODL + XML + COG/GeoTIFF + QA bit fields.

## Four useful end-to-end stacks

```text
Sentinel-2
SAFE directory
  -> XML/XSD
  -> cross-file references
  -> granule/band/resolution identity
  -> JP2 boxes
  -> JPEG 2000 codestream
  -> pixels

MODIS
HDF4 bytes
  -> descriptor/tag object graph
  -> HDF-EOS2 Grid/Swath
  -> MODIS product conventions
  -> packed sample + QA
  -> calibrated/geolocated observation

GOES-R Level 0
HDF5
  -> netCDF-4
  -> byte-array variable
  -> CCSDS packet framing
  -> APID dispatch
  -> GOES instrument payload
  -> physical observation

Landsat Collection 2
STAC JSON / product listing
  -> MTL/ODL + XML metadata
  -> COG/GeoTIFF asset
  -> QA bit fields
  -> stored digital number
  -> calibrated/geolocated observation
```

## Parser properties worth testing later in Idric

These are questions, not a proposed language design.

### Bounded byte regions

JP2 boxes, TIFF indirect values, HDF objects and CCSDS packet payloads all require a parser to prove that a child object stays inside a parent byte range.

### Width-dependent integers

Examples include TIFF versus BigTIFF offsets, HDF5 file-defined offset widths, HDF4 fixed legacy widths, 11-bit CCSDS APIDs and 14-bit sequence counts.

### Length-indexed payloads

CCSDS gives a particularly crisp case: the decoded 16-bit value is one less than the actual packet-data length. A validated packet should not be able to contain a payload of the wrong length.

### Shape-indexed arrays

netCDF, HDF/HDF-EOS, MODIS and raster products all carry array dimensions as data. A useful question is whether a validated array can expose shape agreement as structure rather than relying on later runtime convention.

### Representation versus physical values

GOES, MODIS and Landsat commonly store packed integers plus fill/range/scaling metadata. Raw stored samples, invalid/fill states and calibrated physical values should be distinct stages.

### Bit fields

Landsat QA and CCSDS primary headers both turn integer storage into multiple logical fields with restricted widths and enumerated meanings.

### Version refinement

SAFE schemas, HDF object/header versions, netCDF encodings and product versions all require selecting a grammar before later fields can be interpreted safely.

### Cross-file referential integrity

Sentinel SAFE and Landsat products are graphs of files. A parsed reference and a resolved existing asset are not the same state.

### Semantic layers over generic containers

- HDF4/HDF5 do not by themselves imply HDF-EOS Grid/Swath meaning.
- netCDF does not by itself imply GOES projection/calibration meaning.
- XML does not by itself imply Sentinel product validity.
- GeoTIFF does not by itself imply Landsat band/QA semantics.

This is useful pressure against a design that collapses parsing into `bytes -> record` in one step.

### Recoverable unknowns

Real public-data formats are extensible. Unknown XML elements/attributes, TIFF tags, HDF messages, netCDF attributes, JP2 boxes and APIDs should be preservable or skippable where their enclosing format permits it, without manufacturing false semantic understanding.

### Layer-specific failure

A failed physical-value decode should not erase the fact that the underlying container was structurally valid. These stacks give concrete cases for error values that retain the stage at which validation stopped.

## Initial comparative acceptance cases

1. **CCSDS:** six bytes -> validated primary header -> bounded payload length.
2. **JP2:** bytes -> validated box tree -> bounded codestream slice, no pixel decoder required.
3. **netCDF:** stored variable -> dimensions/attributes -> valid packed sample state.
4. **HDF4/HDF-EOS:** valid container object -> valid Grid/Swath relation.
5. **Sentinel:** valid XML metadata -> resolved product asset -> JP2 metadata cross-check.
6. **Landsat:** STAC/MTL scene -> GeoTIFF band -> QA/raw sample -> calibrated sample.
7. **GOES Level 0:** valid netCDF -> CCSDS stream -> APID-refined packet.

Those seven cases exercise substantially different type-system questions while remaining grounded in documented public data rather than invented toy grammars.
