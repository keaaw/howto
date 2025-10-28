#!/bin/bash
# Make /home and /boot temporary overlay mounts using /tmp (already tmpfs)
# Run this AFTER login (e.g. from ~/.bash_profile or manually)

set -euo pipefail

TMPROOT=/tmp/overlay
MOUNTS=(/home /boot)

echo "[*] Setting up overlay layers under $TMPROOT ..."
sudo mkdir -p "$TMPROOT"

for MNT in "${MOUNTS[@]}"; do
    NAME=$(basename "$MNT")
    LOWER="$MNT"
    UPPER="$TMPROOT/${NAME}-upper"
    WORK="$TMPROOT/${NAME}-work"

    echo "[*] Preparing overlay for $MNT ..."
    sudo mkdir -p "$UPPER" "$WORK"

    # Mount overlay using existing tmpfs-backed /tmp directories
    echo "    -> Mounting overlay on $MNT ..."
    sudo mount -t overlay overlay \
        -o lowerdir="$LOWER",upperdir="$UPPER",workdir="$WORK" \
        "$MNT"

    echo "    [$MNT] now running as overlay"
done

echo "[✓] Overlays active for: ${MOUNTS[*]}"
