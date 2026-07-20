# Pacific Linux

A Debian-based desktop Linux distribution built for the Pacific Islands as a
region — Melanesia, Polynesia, and Micronesia — not one country. Designed
around the region's real conditions: expensive/unreliable bandwidth, aging
donated hardware, many languages, and routine cyclone/tsunami/earthquake
exposure.

Full plan: [ROADMAP.md](ROADMAP.md) (also available as
[Pacific-Linux-Roadmap.pdf](Pacific-Linux-Roadmap.pdf) /
[.html](Pacific-Linux-Roadmap.html)).

## Status

**Phase 1 — MVP respin, nearly complete.** Boots and installs cleanly,
verified on both QEMU/KVM and real hardware (a Blackview mini PC): branding
(logo, wallpaper, Plymouth boot theme), the full preinstalled app set,
Synaptic as the software center, a low-bandwidth-aware update notifier, and
the Calamares installer. Remaining Phase 1 item: the custom first-run
welcome app (language picker). See [ROADMAP.md](ROADMAP.md) for what's
next after that.

## Base

- Debian 13 (trixie) stable
- XFCE desktop
- `live-build` for the ISO, Calamares for the installer

## Repo layout

```
config/          live-build configuration (Phase 1)
branding/         logo, wallpapers, boot splash, icon theme (Phase 1)
locales/          gettext translation catalogs — en, bi (Phase 2)
welcome-app/     first-run language picker / setup (Phase 1)
scripts/          build and maintenance scripts
docs/             supporting documentation
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

Pacific Linux's own code is licensed under [GPL-3.0](LICENSE). The
underlying OS remains Debian and carries its own package licenses.
