# disaster-info/

Offline cyclone/tsunami/earthquake safety info and emergency contacts,
launched on demand (applications menu + desktop icon) rather than
autostarted — this is a reference tool people reach for during or before an
emergency, not a first-run notice like the welcome app.

- `venu-pacific-disaster-info` — the app itself (GTK3 via PyGObject, same
  stack as `welcome-app/` for the same reason: matches XFCE's own native
  GTK3 apps)
- `venu-pacific-disaster-info.desktop` — applications-menu entry
- `content/` — per-country JSON data (see `content/README.md` for the
  schema and how to add a country)

UI chrome strings are gettext-wrapped under a separate `venu-pacific-disaster`
domain (not the welcome app's `venu-pacific` domain), so the catalogs stay
independently sized as more countries get added. The per-country content
itself is English-only for v1 — see `content/README.md` for why that's
handled separately from the gettext pipeline.

Wired into the build via `config/config/includes.chroot/usr/local/bin/`,
`.../usr/share/applications/`, and `.../usr/share/venu-pacific/disaster-info/`
— copies of the files here, kept in sync manually (same pattern as
`branding/` and `welcome-app/`).
