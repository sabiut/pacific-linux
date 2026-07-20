# welcome-app/

First-run window, shown once per user via an XDG autostart entry (same
marker-file pattern as `pacific-linux-set-defaults`). GTK3 via PyGObject —
matches XFCE's own native apps here, which are still GTK3 (`xfdesktop 4.20`
itself reports "Built with GTK+ 3.24"), rather than adding a second GTK
stack for one small window.

- `pacific-linux-welcome` — the app itself
- `pacific-linux-welcome.desktop` — the autostart entry

Deliberately honest about v1's actual language scope: the language section
shows English (active) and Bislama (visibly present but disabled, labeled
"coming in a future update") rather than hiding it or faking a working
switch — full translation infrastructure is a Phase 2 item, not yet built.

Wired into the build via `config/config/includes.chroot/usr/local/bin/` and
`.../etc/xdg/autostart/` — these are copies of the files here, kept in sync
manually (same pattern as `branding/`).
