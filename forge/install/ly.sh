#!/usr/bin/env bash
# FINAL – SDDM + Catppuccin Frappé Green (actually works, no more errors)
set -euo pipefail

echo "=== Full cleanup of old login managers ==="
sudo systemctl disable --now greetd ly sddm 2>/dev/null || true
sudo pacman -Rns --noconfirm greetd greetd-tuigreet ly 2>/dev/null || true

echo "=== Installing /usr/share/sddm/themes/catppuccin-frappe-green – NUKING any old/broken version ==="
sudo rm -rf /usr/share/sddm/themes/catppuccin-frappe-green

echo "=== Downloading fresh Catppuccin Frappé Green theme ==="
sudo curl -L -o /tmp/catppuccin-frappe-green-sddm.zip \
  https://github.com/catppuccin/sddm/releases/download/v1.1.2/catppuccin-frappe-green-sddm.zip

echo "=== Extracting theme ==="
sudo unzip -o /tmp/catppuccin-frappe-green-sddm.zip -d /tmp/
sudo mv /tmp/catppuccin-frappe-green /usr/share/sddm/themes/catppuccin-frappe-green
sudo rm /tmp/catppuccin-frappe-green-sddm.zip

echo "=== Writing perfect /etc/sddm.conf (Wayland + theme) ==="
sudo mkdir -p /etc/sddm.conf.d
sudo tee /etc/sddm.conf > /dev/null <<'EOF'
[General]
DisplayServer=wayland
GreeterEnvironment=QT_WAYLAND_SHELL_INTEGRATION=layer-shell

[Theme]
Current=catppuccin-frappe-green
EOF

echo "=== Enabling SDDM ==="
sudo systemctl enable sddm
sudo systemctl start sddm
