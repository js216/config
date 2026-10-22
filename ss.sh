#!/bin/sh
# Drag-select a region, save to ~/temp/aaa-<unixtime>.png and copy to clipboard.
export DISPLAY="${DISPLAY:-:0}"
f="$HOME/temp/aaa-$(date +%s).png"
sleep 0.2  # let the hotkey release so import can grab the pointer
import "$f" || exit 1
xclip -selection clipboard -t image/png -i "$f"
