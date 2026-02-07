#!/usr/bin/env bash

set -euo pipefail

source "$DOT_HOME/forge/lib/lib.sh"

DIR="$DOT_HOME/forge/install/packages"

out "Checking packages availability" green

shopt -s nullglob

for FILE in "$DIR"/*; do
    EXT="${FILE##*.}"

    while IFS= read -r pkg; do
        [[ -z "$pkg" ]] && continue

        case "$EXT" in
            pac)
                if ! pacman -Si "$pkg" &>/dev/null; then
                    out "Not found (pacman): $pkg → $FILE" red
                fi
                ;;
            aur)
                if ! yay -Si "$pkg" &>/dev/null; then
                    out "Not found (AUR): $pkg → $FILE" red
                fi
                ;;
        esac
    done < "$FILE"
done

