#!/usr/bin/env bash
set -euo pipefail

# Installs sddmstyler directly from the GitHub repository (no local copy needed).
DEST="/usr/local/bin/sddmstyler"
RAW_URL="https://raw.githubusercontent.com/veo47/sddmstyler/main/sddmstyler"

if [ "$(id -u)" -ne 0 ]; then
    echo "run as root:  sudo $0" >&2
    exit 1
fi

echo ">> Downloading sddmstyler from $RAW_URL"
curl -fsSL -o "$DEST" "$RAW_URL"
chmod 755 "$DEST"

echo "installed sddmstyler -> $DEST"
echo "try it:  sddmstyler"