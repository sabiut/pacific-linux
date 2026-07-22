# welcome-app/

First-run window, shown once per user via an XDG autostart entry (same
marker-file pattern as `venu-pacific-set-defaults`). GTK3 via PyGObject —
matches XFCE's own native apps here, which are still GTK3 (`xfdesktop 4.20`
itself reports "Built with GTK+ 3.24"), rather than adding a second GTK
stack for one small window.

- `venu-pacific-welcome` — the app itself
- `venu-pacific-welcome.desktop` — the autostart entry

The gettext framework is built (see `locales/`) — every user-facing string
is wrapped in `_()` and resolved via
`/usr/share/locale/<lang>/LC_MESSAGES/venu-pacific.mo` at runtime. English
and Bislama both have real, reviewed translations as of Phase 2 —
`locales/bi/venu-pacific.po` was reviewed and corrected by a fluent
speaker (not machine-translated or guessed). Both language options in the
welcome app's language section are enabled.

Wired into the build via `config/config/includes.chroot/usr/local/bin/` and
`.../etc/xdg/autostart/` — these are copies of the files here, kept in sync
manually (same pattern as `branding/`).
