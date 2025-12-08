#!/bin/bash

# Loop forever, checking every 1 second
while true; do
    # Get the active workspace name/number
    active_ws=$(hyprctl activeworkspace -j | jq -r '.name')

    # Get all floating clients as JSON array (floating == true)
    clients=$(hyprctl clients -j | jq -c '.[] | select(.floating == true)')

    # Loop over each floating client
    echo "$clients" | while read -r client; do
        # Skip if not JSON (edge case)
        if [[ -z "$client" ]]; then continue; fi

        # Extract workspace and address for this client
        ws=$(echo "$client" | jq -r '.workspace.id')
        addr=$(echo "$client" | jq -r '.address')

        # Skip if already on active workspace
        if [[ "$ws" == "$active_ws" ]]; then continue; fi

        # Move to active workspace silently (no focus change)
        hyprctl dispatch movetoworkspacesilent "$active_ws,address:$addr"
    done

    # Wait 1 second
    sleep 0.5
done
