# services-directory/content/

One JSON file per country, installed to
`/usr/share/pacific-linux/services-directory/` and loaded at runtime by
`pacific-linux-services-directory`. Adding a country is a content task, not
an engineering one — copy an existing file, replace the content, and cite
an official source for every entry (same standard as `disaster-info/`).

## Schema

```json
{
  "name": "Country Name",
  "categories": {
    "government": {
      "label": "Government Services",
      "items": [
        {
          "name": "Passport Renewal",
          "agency": "Department name",
          "contact": "phone/address/website",
          "description": "One or two sentences on what the service involves."
        }
      ]
    },
    "health": { "label": "Health Facilities", "items": [ { "name": "...", "location": "...", "contact": "...", "description": "..." } ] },
    "education": { "label": "Education", "items": [ { "name": "...", "agency": "...", "contact": "...", "description": "..." } ] }
  },
  "sources": [
    {"label": "Name of the official source", "url": "https://..."}
  ]
}
```

- Each item's `agency`/`location`/`contact` fields are all optional and
  shown together as a single line — use whichever apply (a hospital has a
  `location`, a government department has an `agency`, most things have a
  `contact`).
- `sources` should point at official government sites, not tourism sites
  or blogs.
- English-only for v1, same reasoning as `disaster-info/content/README.md`.

## Countries covered

- `vanuatu.json`
- `fiji.json`
