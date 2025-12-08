#!/bin/sh
set -euo pipefail

source "$DOT_HOME/forge/lib/lib.sh"

DIR="$DOT_HOME/forge/install/packages"

print "Checking Packages" green

for FILE in "$DIR"/*; do
  EXT="${FILE##*.}"

  case "$EXT" in
    pac)
      CMD="pacman -Si"
      ;;
    aur)
      CMD="yay -Si"
      ;;
    mise)
      CMD="mise tool"
      ;;
    *)
      continue
      ;;
  esac

  while IFS= read -r pkg; do
    [ -z "$pkg" ] && continue

    if ! $CMD "$pkg" >/dev/null 2>&1; then
      print "Not Found: $pkg - $FILE" red
    fi
  done < "$FILE"
done

