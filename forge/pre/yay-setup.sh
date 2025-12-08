#!/bin/bash

set -euo pipefail

# Source libraries via symlink
source "$DOT_HOME/forge/lib/lib.sh"

if is_installed "yay"; then
    print "Yay already installed" green
    exit 0
fi

print "Installing dependencies" blue
sudo pacman -S --needed git base-devel --noconfirm

echo ""
print "Cloning yay repo" blue

tmp_dir="/tmp/yay"

# clean old clone safely
[[ -d "$tmp_dir" ]] && rm -rf "$tmp_dir"

git clone https://aur.archlinux.org/yay.git "$tmp_dir"

cd "$tmp_dir"

echo ""
print "Installing yay" blue
makepkg -si --noconfirm

cd /

print "Clean up" blue
rm -rf "$tmp_dir"

