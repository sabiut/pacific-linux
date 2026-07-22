# ai-assistant/

Offline chat assistant (Phase 5 — see `ROADMAP.md`, local-only, not
committed). GTK3/PyGObject, same stack as every other app in this repo, so it
matches XFCE's own native GTK3 apps and stays consistent with the rest of the
codebase (not GTK4, despite an earlier research proposal suggesting it —
this repo's own established pattern wins).

- `venu-pacific-assistant` — the app itself. Spawns `llama-server` (from
  `/opt/venu-pacific/llama.cpp/bin/`, built by
  `config/config/hooks/normal/0170-venu-pacific-ai-assistant.hook.chroot`)
  on demand when the window opens, and stops it when the window closes — no
  idle RAM cost when the assistant isn't actually in use, which matters on
  the low-spec/donated hardware this project targets.
- `venu-pacific-assistant.desktop` — applications-menu entry.

## What this MVP is, and isn't

This is a working chat UI wired to the router model (Qwen3-4B), nothing
more yet. Two things are deliberately **not** part of this pass — see
`ROADMAP.md`'s Phase 5 "Build staging" list:

- **No offline knowledge-base/RAG wiring.** The assistant currently answers
  from the model's own general knowledge, not retrieval over
  `disaster-info/`/`services-directory/` content. That's a follow-up step.
- **No desktop actions.** The assistant can't open settings, install
  software, or do anything on the system yet — it's chat-only.

## Translation

There's no dedicated translation model bundled — the assistant handles
translation (EN/FR ↔ Bislama) by direct prompting of the same router model.
This was a deliberate decision made *after* testing a dedicated
OPUS-MT + retrieval-augmented post-editing pipeline for real: that pipeline
caught one genuine safety-critical bug (a mistranslated official earthquake
phrase that had inverted its meaning) but missed another and likely
introduced a different error on real Bislama vocabulary. Direct prompting
without any dedicated model tested clearly worse on the same sentences. The
simplification here is an accepted quality tradeoff for architectural
simplicity, not a neutral choice — see `ROADMAP.md`'s Phase 5 section for
the full reasoning and test results. The app's own UI carries a visible
"may be inaccurate" disclaimer as a direct consequence of this.

**None of this changes how the actual shipped disaster-info/services-directory
content or UI strings get produced** — those stay human-authored and
reviewed, exactly as before.

Wired into the build via `config/config/includes.chroot/usr/local/bin/` and
`.../usr/share/applications/` — copies of the files here, kept in sync
manually (same pattern as every other app). The llama.cpp binaries and
Qwen3-4B model itself are built/downloaded at image-build time by the hook
script above, not committed to git.
