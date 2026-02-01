#!/usr/bin/env bash
set -euo pipefail
source "$DOT_HOME/forge/lib/lib.sh"

out "→ Creating user config directories..." blue

mkdir -p "$HOME/.config/ghostty/"
mkdir -p "$HOME/.config/nvim/lua/config/"
mkdir -p "$HOME/.config/nvim/lua/plugins/"
mkdir -p "$HOME/.config/hypr/scripts/"
mkdir -p "$HOME/.config/mako"
mkdir -p "$HOME/.config/rofi"
mkdir -p "$HOME/.config/waybar/"
mkdir -p "$HOME/.config/zsh"

# For the sudo one, quote as well (though /usr/share/... is safe)
sudo mkdir -p "/usr/share/wayland-sessions"
