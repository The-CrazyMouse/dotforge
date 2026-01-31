#!/usr/bin/env bash
set -euo pipefail

# ... your previous mkdir stuff here ...

DOTS="${DOT_HOME}/forge/config"   # adjust if your path is different, e.g. ~/dotforge/config

echo "→ Creating symlinks for user configs..."

# Ghostty
ln -sf "$DOTS/ghostty/config"          "$HOME/.config/ghostty/config"

# Hyprland (all main files + scripts/)
ln -sf "$DOTS/hypr/binds.conf"         "$HOME/.config/hypr/binds.conf"
ln -sf "$DOTS/hypr/env-var.conf"       "$HOME/.config/hypr/env-var.conf"
ln -sf "$DOTS/hypr/hyprland.conf"      "$HOME/.config/hypr/hyprland.conf"
ln -sf "$DOTS/hypr/input.conf"         "$HOME/.config/hypr/input.conf"
ln -sf "$DOTS/hypr/looknfeel.conf"     "$HOME/.config/hypr/looknfeel.conf"
ln -sf "$DOTS/hypr/monitors.conf"      "$HOME/.config/hypr/monitors.conf"
ln -sf "$DOTS/hypr/startup.conf"       "$HOME/.config/hypr/startup.conf"
# scripts subdir
ln -sf "$DOTS/hypr/scripts/float.sh"   "$HOME/.config/hypr/scripts/float.sh"
ln -sf "$DOTS/hypr/scripts/move.sh"    "$HOME/.config/hypr/scripts/move.sh"

# Mako
ln -sf "$DOTS/mako/config"             "$HOME/.config/mako/config"

# Neovim (source = neovim/, target = nvim/)
ln -sf "$DOTS/neovim/init.lua"         "$HOME/.config/nvim/init.lua"
# lua/config/*
ln -sf "$DOTS/neovim/lua/config/autocmds.lua"  "$HOME/.config/nvim/lua/config/autocmds.lua"
ln -sf "$DOTS/neovim/lua/config/keymaps.lua"   "$HOME/.config/nvim/lua/config/keymaps.lua"
ln -sf "$DOTS/neovim/lua/config/options.lua"   "$HOME/.config/nvim/lua/config/options.lua"
# lua/plugins/*
ln -sf "$DOTS/neovim/lua/plugins/alpha.lua"    "$HOME/.config/nvim/lua/plugins/alpha.lua"
ln -sf "$DOTS/neovim/lua/plugins/cmp.lua"      "$HOME/.config/nvim/lua/plugins/cmp.lua"
ln -sf "$DOTS/neovim/lua/plugins/color.lua"    "$HOME/.config/nvim/lua/plugins/color.lua"
ln -sf "$DOTS/neovim/lua/plugins/fugitive.lua" "$HOME/.config/nvim/lua/plugins/fugitive.lua"
ln -sf "$DOTS/neovim/lua/plugins/gitsigns.lua" "$HOME/.config/nvim/lua/plugins/gitsigns.lua"
ln -sf "$DOTS/neovim/lua/plugins/harpoon.lua"  "$HOME/.config/nvim/lua/plugins/harpoon.lua"
ln -sf "$DOTS/neovim/lua/plugins/lsp.lua"      "$HOME/.config/nvim/lua/plugins/lsp.lua"
ln -sf "$DOTS/neovim/lua/plugins/lualine.lua"  "$HOME/.config/nvim/lua/plugins/lualine.lua"
ln -sf "$DOTS/neovim/lua/plugins/pairs.lua"    "$HOME/.config/nvim/lua/plugins/pairs.lua"
ln -sf "$DOTS/neovim/lua/plugins/telescope.lua" "$HOME/.config/nvim/lua/plugins/telescope.lua"
ln -sf "$DOTS/neovim/lua/plugins/tmux.lua"     "$HOME/.config/nvim/lua/plugins/tmux.lua"
ln -sf "$DOTS/neovim/lua/plugins/todo.lua"     "$HOME/.config/nvim/lua/plugins/todo.lua"
ln -sf "$DOTS/neovim/lua/plugins/treesitter.lua" "$HOME/.config/nvim/lua/plugins/treesitter.lua"
ln -sf "$DOTS/neovim/lua/plugins/undotree.lua" "$HOME/.config/nvim/lua/plugins/undotree.lua"

# Rofi (config + future colors dir — symlink even if empty for now)
ln -sf "$DOTS/rofi/config.rasi"        "$HOME/.config/rofi/config.rasi"
# colors/* (add more later as you populate)
# ln -sf "$DOTS/rofi/colors/adapta.rasi" "$HOME/.config/rofi/colors/adapta.rasi"
# ... repeat for each theme when ready

# Waybar
ln -sf "$DOTS/waybar/config"           "$HOME/.config/waybar/config"
ln -sf "$DOTS/waybar/style.css"        "$HOME/.config/waybar/style.css"

# Zsh
ln -sf "$DOTS/zsh/.zshenv"             "$HOME/.config/zsh/.zshenv"
ln -sf "$DOTS/zsh/.zshrc"              "$HOME/.config/zsh/.zshrc"

echo "→ Creating symlinks for system files (sudo)..."

# Hyprland session desktop file
sudo ln -sf "$DOTS/system/hyprland.desktop" "/usr/share/wayland-sessions/hyprland.desktop"

# pacman.conf → /etc/pacman.conf
# WARNING: Overwriting /etc/pacman.conf can break updates if not careful!
# For prototype: symlink it (but backup first in real use)
sudo cp /etc/pacman.conf /etc/pacman.conf.bak.$(date +%Y%m%d)  # simple timestamp backup
sudo ln -sf "$DOTS/system/pacman.conf" "/etc/pacman.conf"

echo "Symlinks created."
echo "→ Tip: Run 'ls -l ~/.config/*' to verify."
