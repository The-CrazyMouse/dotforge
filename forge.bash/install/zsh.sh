#!/usr/bin/env bash

set -euo pipefail

source "$DOT_HOME/forge.bash/lib/lib.sh"

# Install Oh My Zsh (interactive is fine since you can exit)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Set custom path for Oh My Zsh
export ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.config/oh-my-zsh/custom}"
mkdir -p "$ZSH_CUSTOM/plugins"

# Clone plugins if they don't already exist
[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] && \
    git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions"

[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

