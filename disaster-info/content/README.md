# disaster-info/content/

One JSON file per country, installed to `/usr/share/venu-pacific/disaster-info/`
and loaded at runtime by `venu-pacific-disaster-info`. Adding a country is a
content task, not an engineering one — copy an existing file, replace the
content, and make sure every fact is cited against an official source (see
below). This content can genuinely put someone in danger if it's wrong, so
accuracy matters more than speed here.

## Schema

```json
{
  "name": "Country Name",
  "emergency_contacts": [
    {"service": "Police", "number": "..."},
    {"service": "Fire", "number": "..."},
    {"service": "Ambulance", "number": "..."},
    {"service": "National Disaster Management Office", "number": "..."}
  ],
  "hazards": {
    "cyclone": {
      "label": "Cyclone",
      "before": ["...", "..."],
      "during": ["...", "..."],
      "after": ["...", "..."]
    },
    "tsunami": { "label": "Tsunami", "before": [...], "during": [...], "after": [...] },
    "earthquake": { "label": "Earthquake", "before": [...], "during": [...], "after": [...] }
  },
  "sources": [
    {"label": "Name of the official source", "url": "https://..."}
  ]
}
```

- `hazards` keys can be a subset if a hazard genuinely doesn't apply to a country
  (e.g. some Pacific nations have negligible earthquake risk) — don't include a
  hazard just to fill out the schema.
- `sources` should point at official government/meteorological/NDMO sources,
  not tourism sites or blogs — these are shown in the app itself so users (and
  future contributors checking accuracy) can verify where the info came from.
- English-only for v1. Translating this content is a separate future task from
  the UI chrome (which is gettext-wrapped) — `xgettext` can't extract strings
  out of JSON the way it does Python source, so this would need its own
  per-language file (e.g. `vanuatu.bi.json`) rather than a `.po` catalog.

## Countries covered

- `vanuatu.json`
- `fiji.json`

More can be added the same way — see the roadmap's Phase 2 scope for the
full list of Pacific nations eventually worth covering.
