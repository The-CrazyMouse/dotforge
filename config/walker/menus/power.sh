#!/usr/bin/env bash
# ~/.config/walker/power-menu.sh — Fixed for Walker dmenu (no --prompt)

# Options with Nerd Font icons (Omarchy-style)
OPTIONS=(
    " Shutdown"
    " Reboot"
    " Suspend"
    " Hibernate"
    " Lock Screen"
    " Logout"
    " Cancel"
)

# Pipe to Walker dmenu (no --prompt flag!)
CHOICE=$(printf '%s\n' "${OPTIONS[@]}" | walker --dmenu)

# Exit if nothing selected (Esc/empty)
[[ -z "$CHOICE" ]] && exit 0

# Map choice to action (with confirmation for poweroff/reboot/hibernate)
case "$CHOICE" in
    *"Shutdown"|"*Reboot"|"*Hibernate")
        # Quick yes/no confirm (using another tiny dmenu—keeps it snappy)
        CONFIRM=$(printf '%s\n' "Yes" "No" | walker --dmenu)
        [[ "$CONFIRM" != "Yes" ]] && exit 0
        ;;
esac

# Execute
case "$CHOICE" in
    *"Shutdown")    systemctl poweroff ;;
    *"Reboot")      systemctl reboot ;;
    *"Suspend")     systemctl suspend ;;
    *"Hibernate")   systemctl hibernate ;;
    *"Lock Screen") hyprlock ;;                 # Swap for swaylock if needed
    *"Logout")      hyprctl dispatch exit ;;    # Or loginctl terminate-user $USER
    *)              exit 0 ;;
esac
