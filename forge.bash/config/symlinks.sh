#!/usr/bin/env bash
set -euo pipefail

# =============================================================================
# Dotfiles symlink installer
# Safe(r) version – February 2026 edition
# =============================================================================

DOTS="$DOT_HOME/config"                    # your config root

# ──────────────────────────────────────────────────────────────────────────────
# Basic sanity checks
# ──────────────────────────────────────────────────────────────────────────────

if [[ ! -d "$DOTS" ]]; then
    echo "Error: DOTS directory not found → $DOTS" >&2
    echo "Check DOT_HOME ($DOT_HOME) and folder structure." >&2
    exit 1
fi

echo "→ Using dotfiles from: $DOTS"
echo "→ Target: ~/.config/ and system locations"
echo ""

# Optional: uncomment to create dated backups of overwritten real files
# backup_file() {
#     local target="$1"
#     if [[ -e "$target" && ! -L "$target" ]]; then
#         local bak="${target}.bak.$(date +%Y%m%d-%H%M)"
#         echo "→ Backing up real file: $target → $bak"
#         cp -a "$target" "$bak"
#     fi
# }

echo "→ Creating symlinks for user configs..."

# ──────────────────────────────────────────────────────────────────────────────
# Ghostty
# ──────────────────────────────────────────────────────────────────────────────
ln -s "$DOTS/ghostty/config"          "$HOME/.config/ghostty/config"

# ──────────────────────────────────────────────────────────────────────────────
# Hyprland – main config files + scripts/
# ──────────────────────────────────────────────────────────────────────────────
ln -s "$DOTS/hypr/binds.conf"         "$HOME/.config/hypr/binds.conf"
ln -s "$DOTS/hypr/env-var.conf"       "$HOME/.config/hypr/env-var.conf"
ln -s "$DOTS/hypr/hyprland.conf"      "$HOME/.config/hypr/hyprland.conf"
ln -s "$DOTS/hypr/input.conf"         "$HOME/.config/hypr/input.conf"
ln -s "$DOTS/hypr/looknfeel.conf"     "$HOME/.config/hypr/looknfeel.conf"
ln -s "$DOTS/hypr/monitors.conf"      "$HOME/.config/hypr/monitors.conf"
ln -s "$DOTS/hypr/startup.conf"       "$HOME/.config/hypr/startup.conf"

# scripts subdir (create parent if missing – harmless if already exists)
mkdir -p "$HOME/.config/hypr/scripts"
ln -s "$DOTS/hypr/scripts/float.sh"   "$HOME/.config/hypr/scripts/float.sh"
ln -s "$DOTS/hypr/scripts/move.sh"    "$HOME/.config/hypr/scripts/move.sh"

# ──────────────────────────────────────────────────────────────────────────────
# Mako
# ──────────────────────────────────────────────────────────────────────────────
ln -s "$DOTS/mako/config"             "$HOME/.config/mako/config"

# ──────────────────────────────────────────────────────────────────────────────
# Neovim (individual files – you could symlink whole lua/ later)
# ──────────────────────────────────────────────────────────────────────────────
ln -s "$DOTS/neovim/init.lua"         "$HOME/.config/nvim/init.lua"

mkdir -p "$HOME/.config/nvim/lua/config"
ln -s "$DOTS/neovim/lua/config/autocmds.lua"  "$HOME/.config/nvim/lua/config/autocmds.lua"
ln -s "$DOTS/neovim/lua/config/keymaps.lua"   "$HOME/.config/nvim/lua/config/keymaps.lua"
ln -s "$DOTS/neovim/lua/config/options.lua"   "$HOME/.config/nvim/lua/config/options.lua"

mkdir -p "$HOME/.config/nvim/lua/plugins"
ln -s "$DOTS/neovim/lua/plugins/alpha.lua"     "$HOME/.config/nvim/lua/plugins/alpha.lua"
ln -s "$DOTS/neovim/lua/plugins/cmp.lua"       "$HOME/.config/nvim/lua/plugins/cmp.lua"
ln -s "$DOTS/neovim/lua/plugins/color.lua"     "$HOME/.config/nvim/lua/plugins/color.lua"
ln -s "$DOTS/neovim/lua/plugins/fugitive.lua"  "$HOME/.config/nvim/lua/plugins/fugitive.lua"
ln -s "$DOTS/neovim/lua/plugins/gitsigns.lua"  "$HOME/.config/nvim/lua/plugins/gitsigns.lua"
ln -s "$DOTS/neovim/lua/plugins/harpoon.lua"   "$HOME/.config/nvim/lua/plugins/harpoon.lua"
ln -s "$DOTS/neovim/lua/plugins/lsp.lua"       "$HOME/.config/nvim/lua/plugins/lsp.lua"
ln -s "$DOTS/neovim/lua/plugins/lualine.lua"   "$HOME/.config/nvim/lua/plugins/lualine.lua"
ln -s "$DOTS/neovim/lua/plugins/pairs.lua"     "$HOME/.config/nvim/lua/plugins/pairs.lua"
ln -s "$DOTS/neovim/lua/plugins/telescope.lua" "$HOME/.config/nvim/lua/plugins/telescope.lua"
ln -s "$DOTS/neovim/lua/plugins/tmux.lua"      "$HOME/.config/nvim/lua/plugins/tmux.lua"
ln -s "$DOTS/neovim/lua/plugins/todo.lua"      "$HOME/.config/nvim/lua/plugins/todo.lua"
ln -s "$DOTS/neovim/lua/plugins/treesitter.lua" "$HOME/.config/nvim/lua/plugins/treesitter.lua"
ln -s "$DOTS/neovim/lua/plugins/undotree.lua"  "$HOME/.config/nvim/lua/plugins/undotree.lua"

# ──────────────────────────────────────────────────────────────────────────────
# Rofi (config + prepare for colors/ later)
# ──────────────────────────────────────────────────────────────────────────────
mkdir -p "$HOME/.config/rofi"
ln -s "$DOTS/rofi/config.rasi"        "$HOME/.config/rofi/config.rasi"

# Uncomment & add as you create themes:
# mkdir -p "$HOME/.config/rofi/colors"
# ln -svf "$DOTS/rofi/colors/adapta.rasi" "$HOME/.config/rofi/colors/adapta.rasi"
# ln -svf "$DOTS/rofi/colors/onedark.rasi" "$HOME/.config/rofi/colors/onedark.rasi"

# ──────────────────────────────────────────────────────────────────────────────
# Waybar
# ──────────────────────────────────────────────────────────────────────────────
ln -s "$DOTS/waybar/config"           "$HOME/.config/waybar/config"
ln -s "$DOTS/waybar/style.css"        "$HOME/.config/waybar/style.css"

# ──────────────────────────────────────────────────────────────────────────────
# Zsh (assuming ~/.config/zsh/ structure)
# ──────────────────────────────────────────────────────────────────────────────
mkdir -p "$HOME/.config/zsh"
ln -s "$DOTS/zsh/.zshenv"             "$HOME/.config/zsh/.zshenv"
ln -s "$DOTS/zsh/.zshrc"              "$HOME/.config/zsh/.zshrc"

# ──────────────────────────────────────────────────────────────────────────────
# System-level files (requires sudo)
# ──────────────────────────────────────────────────────────────────────────────
echo ""
echo "→ Creating symlinks for system files (sudo required)..."

# Hyprland session file – very common & safe
sudo ln -s "$DOTS/system/hyprland.desktop" "/usr/share/wayland-sessions/hyprland.desktop"

# ──────────────────────────────────────────────────────────────────────────────
# pacman.conf – DANGEROUS – commented out by default
# ──────────────────────────────────────────────────────────────────────────────
echo ""
echo "→ SKIPPED: symlink of /etc/pacman.conf (high risk!)"
echo "   Reasons: pacman upgrades can break symlinks, .pacnew confusion, recovery issues"
echo ""
echo "Recommended safer alternatives (pick one):"
echo "  1. Best long-term → Use Include directive"
echo "     In real /etc/pacman.conf add: Include = /etc/pacman-custom.conf"
echo "     → then symlink ONLY your custom parts there"
echo ""
echo "  2. Use NoUpgrade = etc/pacman.conf"
echo "     + manually merge .pacnew files when they appear"
echo ""
echo "  3. pacman hook that copies your version after upgrades (advanced)"
echo ""
echo "  If you REALLY want the symlink (not recommended):"
# Uncomment only if you accept the risk – and consider chattr +i afterward
# echo "→ Forcing symlink of pacman.conf (RISKY)..."
# sudo cp -v /etc/pacman.conf "/etc/pacman.conf.bak.$(date +%Y%m%d-%H%M)"
# sudo ln -svf "$DOTS/system/pacman.conf" "/etc/pacman.conf"
# echo "→ TIP: sudo chattr +i /etc/pacman.conf  (make immutable – remove with -i)"

echo ""
echo "Symlinks created (or skipped where noted)."
echo "→ Verify with:   ls -l ~/.config/*"
echo "→ Also check:    ls -l /usr/share/wayland-sessions/hyprland.desktop"
echo "→ And:           cat /etc/pacman.conf   (should NOT be your custom one unless you forced it)"
echo ""
echo "Done. Have fun with your Hyprland setup! 🚀"
