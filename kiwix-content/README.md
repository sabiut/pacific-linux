# kiwix-content/

A curated, branded HTML page recommending specific Kiwix ZIM files to
download — not a bundled ZIM file (every genuinely relevant one is
1.8-4.2GB+, which would roughly double the ISO size for every user, working
directly against the project's bandwidth constraint) and not a custom app
(Kiwix's own `kiwix-desktop` binary has no documented way to pre-seed or
filter its built-in library browser, so rather than reverse-engineer an
undocumented Qt settings format, this just curates a shortlist with direct
download links and lets people use Kiwix's existing File → Open).

- `index.html` — the guide itself, opened in Firefox
- `pacific-linux-kiwix-content.desktop` — applications-menu entry

Every recommendation and its direct download URL was verified against
Kiwix's actual OPDS catalog (opds.library.kiwix.org) and download mirror
(download.kiwix.org) before being added — see the page itself for the
honest caveats on each pick (e.g. the agriculture collection being older
public-domain texts, not modern extension material).

Wired into the build via `config/config/includes.chroot/usr/share/pacific-linux/kiwix-content/`
and `.../usr/share/applications/` — copies of the files here, kept in sync
manually (same pattern as `disaster-info/` and `welcome-app/`).
