#!/usr/bin/env bash

set -euo pipefail

if [[ -z "${DOT_HOME:-}" ]]; then
	export DOT_HOME="$HOME/.dotforge"
fi

source "$DOT_HOME/forge.bash/lib/lib.sh"


echo "Installing base dependencies (gum, git, mise)..."
sudo pacman -S --needed --noconfirm gum git

source $DOT_HOME/forge.bash/lib/lib.sh

echo " "
out "Welcome to Dotforge" blue

"$DOT_HOME/forge.bash/pre/all.sh"
"$DOT_HOME/forge.bash/install/all.sh"
"$DOT_HOME/forge.bash/config/all.sh"

