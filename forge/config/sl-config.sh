#!/usr/bin/env bash

set -euo pipefail

DOTFORGE="$HOME/.dotforge/config"

# Function to create directories
mkdir_if_not_exists() {
    [ ! -d "$1" ] && mkdir -p "$1"
}

# Symlink helper
symlink() {
    local src="$1"
    local dst="$2"
    if [ -e "$dst" ] || [ -L "$dst" ]; then
        rm -rf "$dst"
    fi
    ln -s "$src" "$dst"
    echo "Linked $dst -> $src"
}

echo "Creating directories..."
mkdir_if_not_exists "$HOME/.config/ghostty"
mkdir_if_not_exists "$HOME/.config/hypr"
mkdir_if_not_exists "$HOME/.config/hypr/scripts"
mkdir_if_not_exists "$HOME/.config/waybar"
mkdir_if_not_exists "$HOME/.config/zsh"

echo "Symlinking config files..."

# Ghostty
symlink "$DOTFORGE/ghostty/config" "$HOME/.config/ghostty/config"

# Hyprland
for file in binds.conf env-var.conf hyprland.conf input.conf looknfeel.conf monitors.conf startup.conf; do
    symlink "$DOTFORGE/hypr/$file" "$HOME/.config/hypr/$file"
done

# Hyprland scripts
for script in float.sh move.sh; do
    symlink "$DOTFORGE/hypr/scripts/$script" "$HOME/.config/hypr/scripts/$script"
done

# Waybar
symlink "$DOTFORGE/waybar/config" "$HOME/.config/waybar/config"
symlink "$DOTFORGE/waybar/style.css" "$HOME/.config/waybar/style.css"

# Zsh
symlink "$DOTFORGE/zsh/.zshrc" "$HOME/.config/zsh/.zshrc"
symlink "$DOTFORGE/zsh/.zshenv" "$HOME/.zshenv"

# System-wide files (requires sudo)
echo "Symlinking system files..."
sudo ln -sf "$DOTFORGE/system/hyprland.desktop" /usr/share/wayland-sessions/hyprland.desktop
sudo ln -sf "$DOTFORGE/system/sddm.conf" /etc/sddm.conf

echo "Done!"

