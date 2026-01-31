#!/bin/sh
set -euo pipefail

source "$DOT_HOME/forge/lib/lib.sh"


DIR="$DOT_HOME/forge/install/packages"

for FILE in "$DIR"/*; do
  EXT="${FILE##*.}"

  case "$EXT" in
    pac)
      INSTALL_CMD="sudo pacman -S --needed --noconfirm"
      ;;
    aur)
      INSTALL_CMD="yay -S --needed --noconfirm"
      ;;
    *)
      continue
      ;;
  esac

  while IFS= read -r pkg; do
    [ -z "$pkg" ] && continue

    $INSTALL_CMD "$pkg"
  done < "$FILE"
done

