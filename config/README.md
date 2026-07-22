# config/

Live-build configuration for the ISO. Empty for now — this fills in during
**Phase 1 (MVP respin)**.

To populate it:

```sh
sudo apt install live-build
cd config/
lb config \
  --distribution trixie \
  --archive-areas "main contrib non-free non-free-firmware" \
  --binary-images iso-hybrid \
  --debian-installer live
```

That generates the standard live-build tree (`package-lists/`, `includes.chroot/`,
`hooks/normal/`, `bootloaders/`, etc.). Customizations belong there:

- `package-lists/venu-pacific.list.chroot` — XFCE + the Phase 1 preinstalled app set
- `includes.chroot/etc/...` — branding, default settings
- `hooks/normal/` — postinstall scripts (welcome app registration, theming)

Do not commit `chroot/`, `binary/`, or `cache/` — see `.gitignore` at the repo root.
