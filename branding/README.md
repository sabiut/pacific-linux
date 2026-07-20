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
  wallpaper on first XFCE login. Done this way (not baked into a config
  file) because XFCE's per-monitor xfconf property names
  (`monitorDP-1`, `monitorVGA-1`, ...) vary by hardware and can't be
  hardcoded reliably at image-build time.

## Not yet verified

None of this has been seen on an actual boot yet — that only happens once
we run `lb build` and boot the resulting ISO (in a VM first). Treat the
Plymouth theme and the first-login script as "should work per documented
API" until that test happens.
