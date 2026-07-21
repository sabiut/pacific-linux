# services-directory/

Offline reference for government e-services, health facilities, and
education resources, launched on demand (applications menu) rather than
autostarted.

- `pacific-linux-services-directory` — the app itself (GTK3 via PyGObject,
  same stack and structure as `disaster-info/`)
- `pacific-linux-services-directory.desktop` — applications-menu entry
- `content/` — per-country JSON data (see `content/README.md` for the
  schema and how to add a country)

UI chrome strings are gettext-wrapped under a separate
`pacific-linux-services` domain. The per-country content itself is
English-only for v1 — see `content/README.md`.

Wired into the build via `config/config/includes.chroot/usr/local/bin/`,
`.../usr/share/applications/`, and
`.../usr/share/pacific-linux/services-directory/` — copies of the files
here, kept in sync manually (same pattern as `disaster-info/`).
