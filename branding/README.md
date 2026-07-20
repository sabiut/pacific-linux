# branding/

Visual identity for Pacific Linux — a wayfinding star compass crossed with
wave-swell lines (echoing Marshallese stick charts), in a deep-ocean palette.
Chosen deliberately over the palm-tree/sunset cliché.

- `logo/` — `mark.svg` (the star mark, transparent), `icon-square.svg` (badge
  variant with an ink circular backing, for app-icon contexts), `lockup.svg`
  (mark + wordmark, for docs), plus rasterized PNG exports of each.
- `wallpapers/` — `pacific-ocean.{svg,png}`, 1920x1080, the same motif as a
  full desktop background: scattered wayfinding stars, the mark glowing
  bottom-right, a faint horizon swell line. Calm in the top-left where XFCE
  places desktop icons.
- `plymouth/pacific-linux/` — a Plymouth `script`-plugin boot theme: the
  wallpaper as background, the mark centered, and a simple progress bar.
  Written against patterns verified in Debian's own bundled theme
  (`/usr/share/plymouth/themes/spacefun`) rather than from memory, since a
  script error there fails silently at boot.

## Icon theme

Not building a custom icon set for v1 — that's a much larger effort than
Phase 1 branding calls for. Using **Papirus** (`papirus-icon-theme`, in the
package list already): actively maintained, XFCE-friendly, and light enough
for the old hardware this project targets.

## Wired into the build

- `config/config/includes.chroot/usr/share/backgrounds/pacific-linux/` —
  wallpaper
- `config/config/includes.chroot/usr/share/plymouth/themes/pacific-linux/` —
  boot theme
- `config/config/includes.chroot/usr/share/pixmaps/pacific-linux.png` — app
  icon / about-dialog badge
- `config/config/hooks/normal/0100-pacific-linux-plymouth.hook.chroot` —
  activates the Plymouth theme and rebuilds the initramfs at build time
- `config/config/includes.chroot/etc/xdg/autostart/pacific-linux-set-defaults.desktop`
  + `.../usr/local/bin/pacific-linux-set-defaults` — sets the default
  wallpaper on first XFCE login (belt-and-suspenders; see below for the
  actual fix).
- `config/config/includes.chroot/etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml`
  — pre-seeds the backdrop xfconf properties before xfdesktop ever
  constructs itself for a fresh user.
- `config/config/hooks/normal/0120-pacific-linux-xfdesktop-fix.hook.chroot`
  — the actual fix (see below).

## The xfdesktop wallpaper bug (resolved)

trixie ships `xfdesktop4` 4.20.1-1, which has a confirmed bug: it never
renders a configured custom wallpaper. Extensively verified before
concluding this — xfconf properties (`image-path`, `last-image`,
`image-show`, `image-style`, `single-workspace-mode`,
`single-workspace-number`, pre-seeded before construction via `/etc/skel`)
were all confirmed correct via direct `xfconf-query`, yet the image was
**never even opened** (confirmed with `--enable-debug` +
`G_MESSAGES_DEBUG=all`: zero `GdkPixbuf` calls for our file, though icon
loads show up fine in the same trace). Reproduced identically on real
hardware (Blackview mini PC), ruling out a QEMU-only artifact.

**Fix**: `0120-pacific-linux-xfdesktop-fix.hook.chroot` downloads
`xfdesktop4` and `xfdesktop4-data` 4.20.2-2 directly from the Debian pool
(sid) by URL and installs them with `apt-get install ./*.deb` after the
main package set is in — 4.20.2 doesn't have the bug. Every other library
`xfdesktop4` 4.20.2 depends on is already satisfied by trixie's own
package versions (verified against the real `.deb` control file);
`xfdesktop4-data` has no dependencies of its own.

This is a direct download + `dpkg`-level install, deliberately **not** an
apt source pin — an earlier attempt to add sid as a low-priority pinned
archive broke live-build's own `installer_debian-installer` script (it
checks package availability via `apt-cache show | wc -l -eq 1`, which
breaks the moment any second suite has a same-named package, regardless
of pin priority). The direct-download approach also means nothing
sid-related ever ships in the final image.

## Verified by actually booting the ISO (QEMU/KVM + real hardware)

- **Plymouth boot theme** — confirmed working: background, centered mark,
  progress bar all render correctly during boot.
- **Boot menu / installer branding** — confirmed correct (Debian's isolinux
  menu shows the right build metadata; base XFCE desktop boots fine).
- **Desktop wallpaper — confirmed working** after the xfdesktop4 4.20.2
  fix above. Verified on a fresh boot with zero manual intervention: the
  ocean wallpaper renders correctly on first login.
