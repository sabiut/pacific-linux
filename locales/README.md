# locales/

Translation catalogs (gettext `.po`/`.pot`), added in **Phase 2 (Pacific identity
& content)**.

- `en/` — English (source strings, always complete)
- `bi/` — Bislama (v1 launch language per the roadmap's sequencing principle)

`en/` and `bi/` are scaffolded now because they're the committed v1 launch
languages. Adding a language beyond these is meant to stay a translation
task, not an engineering one: copy the `.pot` template into a new
`<lang-code>/` directory and translate the strings — don't add the directory
until someone is actually translating into it.
