#!/usr/bin/env bash

set -euo pipefail

# Source libraries via symlink
source "$DOT_HOME/forge/lib/lib.sh"

if is_installed "yay"; then
    out "Yay already installed" green
    exit 0
fi

out "Installing dependencies" blue
sudo pacman -S --needed git base-devel --noconfirm

echo ""
out "Cloning yay repo" blue

tmp_dir="/tmp/yay"

# clean old clone safely
[[ -d "$tmp_dir" ]] && rm -rf "$tmp_dir"

git clone https://aur.archlinux.org/yay.git "$tmp_dir"

cd "$tmp_dir"

echo ""
out "Installing yay" blue
makepkg -si --noconfirm

cd /

out "Clean up" blue
rm -rf "$tmp_dir"

