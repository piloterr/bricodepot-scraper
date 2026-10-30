#!/usr/bin/env bash
# Brico Dépôt Product API – cURL example
# Usage: PILOTERR_API_KEY=your-key ./product.sh
set -euo pipefail

curl -sS -G "https://api.piloterr.com/v2/bricodepot/product" \
  -H "x-api-key: ${PILOTERR_API_KEY}" \
  --data-urlencode query=https://www.bricodepot.fr/p/3373270014082/compresseur-coaxial-50l-vertical-10-bars-accessoires-1
