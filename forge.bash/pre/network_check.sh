#!/usr/bin/env bash

set -euo pipefail

source "$DOT_HOME/forge.bash/lib/lib.sh"

out "Checking internet connectivity..." blue

# Quick ping test to Arch mirror (or Google DNS)
if ! ping -c 1 -W 3 8.8.8.8 >/dev/null 2>&1; then
    out "No internet connection detected!" red
    out "→ Please connect to a network first (wifi-menu, nmcli, etc.)" yellow
    out "Script will exit now. Run again after connecting." grey
    exit 1
fi
out "Internet OK" green
