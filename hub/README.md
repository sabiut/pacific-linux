# hub/

Single entry-point launcher — five tiles (Ask / Learn / Services / Safety / Translate), each
launching one of the existing standalone apps. Not a rewrite or a merge of them: almost no logic
here beyond `subprocess.Popen(...)`, since all the real functionality already works
independently. Both this and the individual apps' own menu entries stay visible — nothing about
opening an app directly regresses.

- `venu-pacific-hub` — the launcher itself (GTK3 via PyGObject, same stack and structure as the
  other apps)
- `venu-pacific-hub.desktop` — applications-menu entry

Safety (`disaster-info`) and Services (`services-directory`) launch their own fast,
AI-independent apps directly rather than being folded into the assistant's window — deliberate,
so emergency safety info stays usable even if the AI/LLM component is slow to start, crashed, or
never launched at all. See `ROADMAP.md`'s "one app vs several" discussion for the full reasoning.

Translate points at the same command as Ask — there's no separate translate tool, just the
assistant's own translation capability, framed as its own tile since that's a distinct enough
need to be worth surfacing on its own.

UI chrome strings are gettext-wrapped under a separate `venu-pacific-hub` domain (same convention
as every other app here) — no translation catalog exists for it yet, so it's English-only until
one's added, same as how the other apps started.

Wired into the build via `config/config/includes.chroot/usr/local/bin/` and
`.../usr/share/applications/` — copies of the files here, kept in sync manually (same pattern as
every other app in this repo).
