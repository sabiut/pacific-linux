#!/bin/bash
# CI lint checks for Pacific Linux's live-build config: shell syntax,
# systemd unit validity, XML validity, and executable-bit sanity on
# everything that ships into the built image. Run locally with
# ./scripts/lint.sh, or via .github/workflows/ci.yml.
#
# Deliberately writes failures to a file rather than a shell variable —
# the checks below run inside `while read` loops fed by process
# substitution, and relying on a variable set inside a pipeline subshell
# is a classic way to silently lose failures.

set -u
cd "$(dirname "$0")/.."

FAIL_LOG="$(mktemp)"
trap 'rm -f "$FAIL_LOG"' EXIT

check_shell() {
    local f="$1"
    if ! sh -n "$f" 2>&1; then
        echo "FAIL: $f has a shell syntax error" | tee -a "$FAIL_LOG"
    fi
    if [ ! -x "$f" ]; then
        echo "FAIL: $f is not executable (live-build requires this)" | tee -a "$FAIL_LOG"
    fi
}

echo "== live-build hook scripts =="
while IFS= read -r -d '' f; do
    check_shell "$f"
done < <(find config/config/hooks -type f \( -name "*.hook.chroot" -o -name "*.hook.binary" \) -print0 2>/dev/null)

echo "== includes.chroot scripts (usr/local) =="
while IFS= read -r -d '' f; do
    if head -c2 "$f" 2>/dev/null | grep -q '^#!'; then
        check_shell "$f"
    fi
done < <(find config/config/includes.chroot/usr/local -type f -print0 2>/dev/null)

echo "== systemd unit files =="
while IFS= read -r -d '' f; do
    output="$(systemd-analyze verify "$f" 2>&1)" || true
    # ExecStart targets don't exist on the lint host (they're only present
    # in the built rootfs) — that's expected, not a real failure. Anything
    # else systemd-analyze flags is real.
    real_errors="$(echo "$output" | grep -v 'is not executable: No such file or directory' || true)"
    if [ -n "$real_errors" ]; then
        echo "FAIL: $f" | tee -a "$FAIL_LOG"
        echo "$real_errors" | tee -a "$FAIL_LOG"
    fi
done < <(find config/config/includes.chroot -type f \( -name "*.service" -o -name "*.timer" \) -print0 2>/dev/null)

echo "== XML files =="
while IFS= read -r -d '' f; do
    if ! python3 -c "import xml.dom.minidom as m; m.parse('$f')" >/dev/null 2>&1; then
        echo "FAIL: $f is not valid XML" | tee -a "$FAIL_LOG"
    fi
done < <(find config/config/includes.chroot -name "*.xml" -print0 2>/dev/null)

echo
if [ -s "$FAIL_LOG" ]; then
    echo "Lint failed."
    exit 1
fi

echo "Lint passed."
