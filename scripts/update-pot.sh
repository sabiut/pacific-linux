#!/bin/bash
# Regenerates each domain's locales/<domain>.pot from its source strings,
# then merges any new/changed msgids into every locales/*/<domain>.po
# catalog (msgmerge preserves existing translations, marks changed ones
# fuzzy for re-review, and never overwrites a filled-in msgstr with an
# empty one). Requires the `gettext` package (xgettext, msgmerge).
set -eu
cd "$(dirname "$0")/.."

# domain:source-file pairs — add a line here when a new gettext domain
# (a new app with its own catalog) is introduced.
DOMAINS=(
    "pacific-linux:welcome-app/pacific-linux-welcome"
    "pacific-linux-disaster:disaster-info/pacific-linux-disaster-info"
    "pacific-linux-services:services-directory/pacific-linux-services-directory"
)

for entry in "${DOMAINS[@]}"; do
    domain="${entry%%:*}"
    source_file="${entry#*:}"

    xgettext \
        --language=Python \
        --keyword=_ \
        --from-code=UTF-8 \
        --package-name=pacific-linux \
        --msgid-bugs-address=https://github.com/sabiut/pacific-linux/issues \
        --output="locales/$domain.pot" \
        "$source_file"

    for po in locales/*/"$domain.po"; do
        [ -f "$po" ] || continue
        msgmerge --update --backup=off "$po" "locales/$domain.pot"
        echo "updated $po"
    done

    echo "locales/$domain.pot regenerated."
done
