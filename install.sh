#!/usr/bin/env bash
set -euo pipefail

DEST="/usr/local/bin/sddmstyler"
SRC="$(dirname -- "$0")/sddmstyler"

if [ "$(id -u)" -ne 0 ]; then
    echo "run as root:  sudo $0" >&2
    exit 1
fi

install -m 755 -o root -g root "$SRC" "$DEST"
echo "installed sddmstyler -> $DEST"
echo "try it:  sddmstyler"