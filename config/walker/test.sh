#!/usr/bin/env bash
# test.sh — pure Walker selection + pure Bash logic
# Put this anywhere, chmod +x test.sh

# 1. Just the human-readable labels (what Walker will show)
OPTIONS=(
    "Shutdown"
    "Reboot"
    "Suspend"
    "Hibernate"
    "Lock Screen"
    "Logout"
    "Cancel"
)

# 2. Let Walker do ONLY the selection
#    (printf + walker --dmenu is the canonical way)
SELECTED=$(printf "%s\n" "${OPTIONS[@]}" | walker --dmenu)

# 3. If user pressed Esc or selected nothing → exit silently
[[ -z "$SELECTED" ]] && exit 0

# 4. Bash maps the label → real command
case "$SELECTED" in
    "Shutdown")
        read -r -p "Really power off? (y/N) " ans
        [[ "$ans" =~ ^[Yy]$ ]] && systemctl poweroff
        ;;
    "Reboot")
        read -r -p "Really reboot? (y/N) " ans
        [[ "$ans" =~ ^[Yy]$ ]] && systemctl reboot
        ;;
    "Suspend")
        systemctl suspend
        ;;
    "Hibernate")
        systemctl hibernate
        ;;
    "Lock Screen")
        hyprlock        # or swaylock, loginctl lock-session, etc.
        ;;
    "Logout")
        hyprctl dispatch exit   # or loginctl terminate-user $USER
        ;;
    "Cancel")
        exit 0
        ;;
    *)
        # Fallback for anything unexpected
        notify-send "Power menu" "Unknown option: $SELECTED"
        ;;
esac
