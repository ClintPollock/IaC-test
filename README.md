# Overview

This directory contains a build and content for a fairly insecure docker image
with a variety of issues we will want to identify.

Build with:

```
docker build . -f Dockerfile.insecure -t veray-insecure:latest
```

Then test with things like:

## syft

For an SBOM:
```
 syft packages  veray-insecure:latest
```
or in a specific format:
```
 syft packages  veray-insecure:latest  -o spdx
```

For a fuller scan of packages and files ...
```
syft power-user veray-insecure:latest
```
and to get the manifest of files etc:

```
syft power-user veray-insecure:latest | jq '.files[] |  "\(.location.path) | \(.metadata.mode)"' | grep script.sh

```
or secrets
```
syft power-user veray-insecure:latest | jq '.secrets[]'
```


## grype

```
grype veray-insecure:latest -s AllLayers
```
or for SARIF format
```
grype veray-insecure:latest -s AllLayers -o sarif | jq .runs[].results[].ruleId
```

## trivy

Scan the container image
```
trivy image  veray-insecure:latest
```

Or scan its dockerfile etc.
```
trivy config -f json . | jq .Results
```
