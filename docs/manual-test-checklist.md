# Manual test checklist: Calamares install-to-disk

This is the checklist for the one piece of the release path that needs a real mouse and
therefore can't be automated in a headless/scripted VM: actually clicking through Calamares
and confirming the installed system boots. Everything above the "Partitions" step was already
verified in an automated keyboard-only VM boot test before this list was walked through with a
real mouse — see the Result section at the bottom for the outcome.

Use real hardware (or any machine/VM where you have normal mouse+keyboard control) — not a
headless/scripted setup.

## What's already confirmed (no need to re-check)

- Boot menu shows exactly: `Live system (amd64)`, `Live system (amd64 fail-safe mode)`,
  `Utilities` — no conflicting classic-installer entries
- Live desktop boots, wallpaper renders correctly
- Welcome window appears once, dismisses correctly
- Calamares launches from the **Install Debian** desktop icon (or **Install System** in the
  applications menu) with no password prompt, and its sidebar shows all 8 steps: Welcome,
  Location, Keyboard, Partitions, Users, Summary, Install, Finish
- Welcome / Location / Keyboard pages populate with real data (keyboard layouts, timezone map,
  our virtual disk detected on the Partitions page)

**Note**: build the ISO from `main` — it now includes both the Calamares config fix and the
welcome app's button-color fix together.

## Before you start

- [ ] The live session's user account is `user` with **no password** and no longer auto-locks
      on idle (fixed -- light-locker only actually starts on an installed system now, not a
      live boot). If you do somehow hit a lock screen on a live session, that's a regression.
- [ ] Have a way to note down anything that looks wrong (screenshot, or just what step/message)

## 1. Partitions

- [x] Select **Erase disk** (the target/only disk should be pre-selected if there's only one)
- [x] Confirm **Next** becomes clickable once a disk is selected
- [x] Click **Next**

## 2. Users

- [x] Enter a full name, username, password (and confirm), and machine name
- [ ] Confirm validation catches an empty/too-short password if you deliberately test one
- [ ] Note whether "log in automatically" / "use the same password as administrator" checkboxes
      (if present) behave as labeled
- [x] Click **Next**

## 3. Summary

- [x] Review the summary screen — confirm it lists the disk being erased, the user being
      created, and the timezone/keyboard choices from earlier steps correctly
- [x] Click **Install**

## 4. Install

- [x] Confirm the progress bar/log moves (doesn't hang) — this step copies the whole system and
      will take several minutes
- [x] Note any error dialogs, if they appear — screenshot and record the exact text (none seen)
- [x] Confirm it reaches **Finish** without needing you to close an error dialog first

## 5. Finish

- [x] Click **Restart now** (or equivalent) — or manually reboot if it just says to
- [x] **Remove the USB drive** when prompted / before the reboot completes, so it boots from
      the internal disk, not back into the live USB (in the VM test, done by changing boot order
      instead of physically removing media)

## 6. First boot of the installed system

- [x] Machine boots to a bootloader (GRUB) menu or straight to login — either is fine, just
      note which (straight to LightDM login)
- [x] Login screen appears; log in with the username/password from step 2
- [x] Desktop loads with the correct wallpaper (this is the thing the xfdesktop 4.20.1 bug
      originally broke — confirm it still shows correctly on a freshly installed system, not
      just the live session)
- [x] Welcome window shows once on this first login too, with the Get Started button rendering
      correctly (teal, not white-on-white)
- [ ] Dismissing the welcome window means it doesn't show again on a second login/reboot
- [ ] Network, audio, and any built-in wifi work as expected for the hardware (not meaningfully
      testable in a VM — needs real hardware)
- [ ] Synaptic launches and can search for a package (confirms apt/package management works
      post-install)

## Result

**Passed** (2026-07-21, QEMU/KVM VM via virt-manager, `combined-test-build` branch merged into
`main` as PRs #3 and #4): the full Erase Disk → Users → Summary → Install → Finish flow
completed with no errors, and the installed system reboots to a working login, desktop, and
welcome app. The unchecked items above are real gaps worth confirming on real hardware — that's
what's genuinely still open. `docs/install-guide.md`'s "not yet independently verified" note has
been updated to reflect this pass.

## If something fails

Note exactly which numbered step failed, the exact error text or screenshot, and the
hardware/VM you're on — same as the reporting guidance in
[install-guide.md](install-guide.md).
