#!/bin/bash
# ~/.dotforge/config/hypr/scripts/float.sh

FOLLOWER="$HOME/.dotforge/config/hypr/scripts/move.sh"

# If the mover is running → turn everything OFF
if pgrep -f "move.sh" > /dev/null; then
    pkill -f "move.sh"
    hyprctl dispatch togglefloating active 2>/dev/null || true
    exit 0
fi

hyprctl dispatch togglefloating active
hyprctl dispatch resizeactive exact 450 250
hyprctl dispatch moveactive -- calc:100%-370 calc:100%-270
"$FOLLOWER" >/dev/null 2>&1 &

