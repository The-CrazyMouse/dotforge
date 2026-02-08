#!/usr/bin/env bash

set -euo pipefail

source "$DOT_HOME/forge.bash/lib/lib.sh"

out "Phase: Install" blue
echo " "

"$DOT_HOME/forge.bash/install/packages.sh"
"$DOT_HOME/forge.bash/install/grub.sh"
"$DOT_HOME/forge.bash/install/zsh.sh"
