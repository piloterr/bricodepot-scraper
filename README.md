<p align="center">
  <a href="https://www.piloterr.com"><img src="images/banner.png" alt="Brico Dépôt Scraper API by Piloterr – scrape Brico Dépôt data as JSON" width="100%"></a>
</p>

# Brico Dépôt Scraper API

[![Discord](https://img.shields.io/badge/Discord-Join%20the%20community-5865F2?logo=discord&logoColor=white)](https://discord.gg/CFj3ph8aHU) [![Get API key](https://img.shields.io/badge/Piloterr-Get%20a%20free%20API%20key-111827)](https://app.piloterr.com) [![API docs](https://img.shields.io/badge/Docs-OpenAPI-0EA5E9)](https://app.piloterr.com/openapi) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

The **Piloterr Brico Dépôt Scraper API** lets you extract public data from Brico Dépôt as **clean, structured JSON** — no proxies, headless browsers or HTML parsing to maintain. Endpoints available in production:

- **Brico Dépôt Product API** — Read one Brico Dépôt product from its product URL.
- **Brico Dépôt Search API** — Search Brico Dépôt with a /produits/ listing URL, not a keyword box.

Use it for price monitoring, assortment tracking, competitor analysis, product research or catalog enrichment.

| Endpoint | Path | Credits | What you get |
|---|---|---|---|
| [Brico Dépôt Product API](#brico-dépôt-product-api) | `/v2/bricodepot/product` | 1 | Read one Brico Dépôt product from its product URL. You get price, brand, SKU, and availability. |
| [Brico Dépôt Search API](#brico-dépôt-search-api) | `/v2/bricodepot/search` | 1 | Search Brico Dépôt with a /produits/ listing URL, not a keyword box. Page 2 is the same path with /2 at the end. |

## Table of contents

- [How it works](#how-it-works)
- [Brico Dépôt Product API](#brico-dépôt-product-api)
- [Brico Dépôt Search API](#brico-dépôt-search-api)
- [Code examples in other languages](#code-examples-in-other-languages)
- [Practical use cases](#practical-use-cases)
- [Why Piloterr?](#why-piloterr)
- [FAQ](#faq)
- [Related scrapers](#related-scrapers)
- [Support](#support)

## How it works

1. **Create a free Piloterr account** and copy your API key from the [dashboard](https://app.piloterr.com).
2. **Send a `GET` (or `POST`) request** to `https://api.piloterr.com/v2/...` with the header `x-api-key: YOUR_API_KEY`.
3. **Receive structured JSON** — Piloterr handles rendering, proxies, retries and parsing.

```bash
export PILOTERR_API_KEY="your-api-key"
pip install requests        # Python
# TypeScript: Node.js 18+ (native fetch), run with `npx tsx file.ts`
```

> Every endpoint accepts both `GET` (query string) and `POST` (JSON body with the same fields).

## Brico Dépôt Product API

Read one Brico Dépôt product from its product URL. You get price, brand, SKU, and availability.

`GET | POST https://api.piloterr.com/v2/bricodepot/product` · **1 credit per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Product URL `/p/{ean}/{slug}`. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/bricodepot/product",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "https://www.bricodepot.fr/p/3373270014082/compresseur-coaxial-50l-vertical-10-bars-accessoires-1",
    },
    timeout=120,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type BricoDptProduct = {
  sku?: string;
  url?: string;
  gtin?: string;
  name?: string;
  brand?: string;
  image?: string;
  price?: number;
  images?: string[];
  category?: string;
  currency?: string;
  breadcrumb?: string[];
  highlights?: string[];
  price_unit?: string;
  description?: string;
  availability?: string;
  product_code?: string;
  price_display?: string;
};

const params = new URLSearchParams({
  "query": "https://www.bricodepot.fr/p/3373270014082/compresseur-coaxial-50l-vertical-10-bars-accessoires-1",
});

const response = await fetch(`https://api.piloterr.com/v2/bricodepot/product?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as BricoDptProduct;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/bricodepot/product
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "https://www.bricodepot.fr/p/3373270014082/compresseur-coaxial-50l-vertical-10-bars-accessoires-1"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "sku": "3373270014082",
  "url": "https://www.bricodepot.fr/p/3373270014082/compresseur-coaxial-50l-vertical-10-bars-accessoires",
  "gtin": "3373270014082",
  "name": "Compresseur coaxial 50L vertical 10 bars + accessoires",
  "brand": "Prodif",
  "image": "https://media.bricodepot.fr/is/image/KingfisherDigital/3373270014082_07c",
  "price": 109,
  "images": [
    "https://media.bricodepot.fr/is/image/KingfisherDigital/3373270014082_07c"
  ],
  "category": "Compresseur et accessoire",
  "currency": "EUR",
  "breadcrumb": [
    "Produits",
    "Matériau et gros œuvre"
  ],
  "highlights": [
    "Compresseur puissant 10 bars avec accessoires complets",
    "Livré avec un kit complet d’accessoires pratiques."
  ],
  "price_unit": "TTC/La pièce",
  "description": "Compresseur robuste et performant, idéal pour tous vos travaux de bricolage. Sa pression maximale de 10 bar garantit une puissance adapté…",
  "availability": "in_stock",
  "product_code": "101507253",
  "price_display": "109,00 €"
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `sku` | string |  |
| `url` | string |  |
| `gtin` | string |  |
| `name` | string |  |
| `brand` | string |  |
| `image` | string |  |
| `price` | integer |  |
| `images` | string[] |  |
| `category` | string |  |
| `currency` | string |  |
| `breadcrumb` | string[] |  |
| `highlights` | string[] |  |
| `price_unit` | string |  |
| `description` | string |  |
| `availability` | string |  |
| `product_code` | string |  |
| `price_display` | string |  |

## Brico Dépôt Search API

Search Brico Dépôt with a /produits/ listing URL, not a keyword box. Page 2 is the same path with /2 at the end.

`GET | POST https://api.piloterr.com/v2/bricodepot/search` · **1 credit per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Brico Dépôt listing URL under /produits/. |
| `page` | number | — | Page from 1. Page 2 is the /2 path suffix. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/bricodepot/search",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "https://www.bricodepot.fr/produits/outillage/outillage-electroportatif-a-main-et-accessoire/perceuse-visseuse-et-outillage-de-percage/perceuse-visseuse-et-perceuse-a-percussion-sans-fil",
    },
    timeout=120,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type BricoDptSearch = {
  results?: {
    sku?: string;
    url?: string;
    name?: string;
    badge?: string;
    image?: string;
    price?: number;
    currency?: string;
    price_unit?: string;
    price_display?: string;
  }[];
  pagination?: {
    next?: string;
    page?: number;
    per_page?: number;
    total_pages?: number;
    total_results?: number;
  };
};

const params = new URLSearchParams({
  "query": "https://www.bricodepot.fr/produits/outillage/outillage-electroportatif-a-main-et-accessoire/perceuse-visseuse-et-outillage-de-percage/perceuse-visseuse-et-perceuse-a-percussion-sans-fil",
});

const response = await fetch(`https://api.piloterr.com/v2/bricodepot/search?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as BricoDptSearch;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/bricodepot/search
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "https://www.bricodepot.fr/produits/outillage/outillage-electroportatif-a-main-et-accessoire/perceuse-visseuse-et-outillage-de-percage/perceuse-visseuse-et-perceuse-a-percussion-sans-fil"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "results": [
    {
      "sku": "5063022810069",
      "url": "https://www.bricodepot.fr/p/5063022810069/perceuse-visseuse-sans-fil-18-v-50-nm-2-vitesses",
      "name": "Perceuse visseuse sans fil 18 V 50 Nm 2 vitesses",
      "badge": "Nouveau",
      "image": "https://media.bricodepot.fr/is/image/KingfisherDigital/5063022810069_01i?wid=300&hei=300",
      "price": 17.9,
      "currency": "EUR",
      "price_unit": "TTC/pièce",
      "price_display": "17,90 €"
    }
  ],
  "pagination": {
    "next": "https://www.bricodepot.fr/produits/outillage/outillage-electroportatif-a-main-et-accessoire/perceuse-visseuse-et-outillage-de-percage/per…",
    "page": 1,
    "per_page": 36,
    "total_pages": 2,
    "total_results": 63
  }
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `results[]` | object[] |  |
| `results[].sku` | string |  |
| `results[].url` | string |  |
| `results[].name` | string |  |
| `results[].badge` | string |  |
| `results[].image` | string |  |
| `results[].price` | number |  |
| `results[].currency` | string |  |
| `results[].price_unit` | string |  |
| `results[].price_display` | string |  |
| `pagination` | object |  |
| `pagination.next` | string |  |
| `pagination.page` | integer |  |
| `pagination.per_page` | integer |  |
| `pagination.total_pages` | integer |  |
| `pagination.total_results` | integer |  |

## Code examples in other languages

Ready-to-run examples live in the [`examples/`](examples) folder. Each one reads your key from the `PILOTERR_API_KEY` environment variable.

| Language | Product | Search |
|---|---|---|
| cURL (Bash) | [`product`](examples/curl/product.sh) | [`search`](examples/curl/search.sh) |
| PHP | [`product`](examples/php/product.php) | [`search`](examples/php/search.php) |
| C# | [`product`](examples/csharp/Product.cs) | [`search`](examples/csharp/Search.cs) |
| Go | [`product`](examples/go/product.go) | [`search`](examples/go/search.go) |
| Java | [`product`](examples/java/ProductExample.java) | [`search`](examples/java/SearchExample.java) |
| Ruby | [`product`](examples/ruby/product.rb) | [`search`](examples/ruby/search.rb) |
| Node.js | [`product`](examples/nodejs/product.mjs) | [`search`](examples/nodejs/search.mjs) |

## Practical use cases

- **Price monitoring** — Track prices, promotions and availability over time to react to competitors.
- **Assortment & catalog tracking** — Follow new products, delisted items and category changes.
- **Competitor analysis** — Benchmark ranges, brands and positioning across retailers.
- **Product research** — Spot best-sellers and trends from search results.
- **Catalog enrichment** — Pull titles, images and attributes into your PIM or marketplace listings.

## Why Piloterr?

- **No infrastructure** — no proxies, headless browsers or CAPTCHA solving to run yourself.
- **Structured JSON** — stable, documented fields instead of brittle HTML selectors.
- **Pay per request** — transparent credit cost per endpoint, failed requests are retried for you.
- **One API key, hundreds of sources** — Brico Dépôt plus many other e-commerce, search and company data endpoints in the [Piloterr library](https://www.piloterr.com/library).
- **Any language** — plain HTTPS + JSON, with examples for Python, TypeScript, cURL, PHP, C#, Go, Java, Ruby and Node.js.

## FAQ

### Is it legal to scrape Brico Dépôt?

Collecting publicly available data is generally allowed in many jurisdictions, but rules depend on your country, the data you collect and how you use it. Avoid personal data unless you have a lawful basis, respect the website's terms where they apply, and get legal advice for your specific use case. This is not legal advice.

### Do I need proxies or a headless browser?

No. Piloterr handles rendering, proxy rotation and retries on its side. You only send an HTTPS request with your `x-api-key` header and receive JSON.

### How much does a request cost?

Credits per call: `/v2/bricodepot/product` **1**, `/v2/bricodepot/search` **1**. See the [Piloterr website](https://www.piloterr.com) for plans.

### What data does the Brico Dépôt API return?

Each endpoint returns structured JSON: **Brico Dépôt Product** — `sku`, `url`, `gtin`, `name`, `brand`, `image`; **Brico Dépôt Search** — `results[]`, `results[].sku`, `results[].url`, `results[].name`, `results[].badge`, `results[].image`.

### How do I paginate Brico Dépôt results?

Use the `page` parameter and keep requesting while the response indicates more results.

### Which languages are supported?

Any language that can make an HTTP request. This README shows Python and TypeScript; the [`examples/`](examples) folder contains cURL, PHP, C#, Go, Java, Ruby and Node.js.

## Related scrapers

- [About You Scraper API](https://github.com/piloterr/aboutyou-scraper)
- [Action Scraper API](https://github.com/piloterr/action-scraper)
- [Aldi Scraper API](https://github.com/piloterr/aldi-scraper)
- [Alibaba Scraper API](https://github.com/piloterr/alibaba-scraper)
- [AliExpress Scraper API](https://github.com/piloterr/aliexpress-scraper)
- [Allegro Scraper API](https://github.com/piloterr/allegro-scraper)
- [All Piloterr scrapers on GitHub](https://github.com/piloterr)

## Support

- 💬 Join the [Piloterr Discord](https://discord.gg/CFj3ph8aHU) to ask questions and share what you build.
- 📚 Browse the [API reference (OpenAPI)](https://app.piloterr.com/openapi) and the [Piloterr library](https://www.piloterr.com/library).
- 🔑 [Get your API key](https://app.piloterr.com).

---

<p align="center">
  <a href="https://www.piloterr.com">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="images/logo-dark.svg">
      <img src="images/logo.svg" alt="Piloterr" height="32">
    </picture>
  </a>
  <br>
  <sub>Built by <a href="https://www.piloterr.com">Piloterr</a> — web scraping APIs for e-commerce, search, real estate and more, one API key.</sub>
</p>

<sub>Brico Dépôt is a trademark of its respective owner. This repository is not affiliated with or endorsed by Brico Dépôt. Examples are released under the MIT license.</sub>
