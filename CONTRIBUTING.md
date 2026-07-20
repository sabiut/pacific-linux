# Contributing to Pacific Linux

Thanks for helping build this. A few ground rules that follow directly from
the [roadmap](ROADMAP.md):

## The sequencing principle

We are **not** trying to support every Pacific language and country at once
— that's the most common way projects like this stall. v1 ships English +
Bislama. Everything is built so adding a language or country later is a
translation/content task, not an engineering one. If you want to bring your
own language or country in, the localization framework (once it lands in
Phase 2) is the place to do it — please don't ask for special-casing in the
core build.

## What we're looking for right now (Phase 0/1)

- Testing on real, aging Pacific-region hardware (this matters more than
  testing on a modern laptop — that's not the target device)
- Package list review for `config/` once live-build config lands
- Branding assets (`branding/`) — logo, wallpaper, icon direction
- Anyone from a pilot school/NGO/office willing to test an early ISO

## Translations

Once `locales/` has a `.pot` template (Phase 2), translating is:

1. Copy the template into `locales/<lang-code>/`
2. Translate the strings
3. Open a PR — a native speaker review is required before merge

## Code changes

- Keep the desktop XFCE-class in resource use — the target machine is an
  8-15 year old donated laptop, not a modern one
- Don't add features ahead of the phase they belong to (see ROADMAP.md) —
  small, working increments over speculative scope
- Explain platform-specific or region-specific decisions in code comments;
  everything else should be self-explanatory

## Reporting issues

Open a GitHub issue (once the repo has a remote) describing what you tried,
what happened, and your hardware/locale if relevant — that context matters
more here than on a typical desktop-Linux bug report.
