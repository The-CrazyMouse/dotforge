#!/usr/bin/env bash

set -euo pipefail

if [[ -z "${DOT_HOME:-}" ]]; then
	export DOT_HOME="$HOME/.dotforge"
fi

source "$DOT_HOME/forge/lib/lib.sh"


out "Installing base dependencies (gum, git, mise)..." blue
sudo pacman -S --needed --noconfirm gum git mise

source $DOT_HOME/forge/lib/lib.sh

echo " "
out "Welcome to Dotforge" blue

"$DOT_HOME/forge/pre/all.sh"
"$DOT_HOME/forge/install/all.sh"
"$DOT_HOME/forge/config/all.sh"

