#!/usr/bin/env bash

set -euo pipefail

source "$DOT_HOME/forge.bash/lib/lib.sh"

out "Phase: Pre-install" blue
echo " "

"$DOT_HOME/forge.bash/pre/network_check.sh"
"$DOT_HOME/forge.bash/pre/pacman_config.sh"
"$DOT_HOME/forge.bash/pre/pacman_update.sh"
"$DOT_HOME/forge.bash/pre/yay-setup.sh"
"$DOT_HOME/forge.bash/pre/check_packages.sh"
