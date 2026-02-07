#!/usr/bin/env bash

set -euo pipefail

source "$DOT_HOME/forge/lib/lib.sh"

# out "Updating Arch keyring..." blue
# sudo pacman -S --needed --noconfirm archlinux-keyring
# sudo pacman-key --refresh-keys || true  # can be slow/noisy, so || true

out "Updating full system..." blue
sudo pacman -Syu --noconfirm || {
    out "System update failed" red
    exit 1
}

