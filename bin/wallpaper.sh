#!/usr/bin/env zsh

WALLPAPERS="$HOME/.dotforge/wallpapers"

echo "Starting wallpaper loop..."
while true; do
  RANDOM_WP=$(find "$WALLPAPERS" -type f | shuf -n 1)
  echo "Selected wallpaper: $RANDOM_WP"

  echo "Getting monitor list..."
  MONITORS=$(hyprctl monitors -j | jq -r '.[].name')
  echo "Monitors found: $MONITORS"

  for MON in $MONITORS; do
    echo "Setting wallpaper on monitor $MON..."
    hyprctl hyprpaper preload "$RANDOM_WP" >/dev/null 2>&1
    hyprctl hyprpaper wallpaper "$MON,$RANDOM_WP" >/dev/null 2>&1
    echo "Wallpaper set on $MON"
  done

  echo "Sleeping for 5 minutes..."
  sleep 300  # 5 minutes
done

