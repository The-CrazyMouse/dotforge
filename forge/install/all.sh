#!/usr/bin/env bash

set -euo pipefail

source "$DOT_HOME/forge/lib/lib.sh"

out "Phase: Install" blue
echo " "

"$DOT_HOME/forge/install/packages.sh"
"$DOT_HOME/forge/install/grub.sh"
"$DOT_HOME/forge/install/zsh.sh"
