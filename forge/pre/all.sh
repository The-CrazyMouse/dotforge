#!/usr/bin/env bash

set -euo pipefail

source "$DOT_HOME/forge/lib/lib.sh"

out "Phase: Pre-install" blue
echo " "

"$DOT_HOME/forge/pre/network_check.sh"
"$DOT_HOME/forge/pre/pacman_config.sh"
"$DOT_HOME/forge/pre/pacman_update.sh"
"$DOT_HOME/forge/pre/yay-setup.sh"
"$DOT_HOME/forge/pre/check_packages.sh"
