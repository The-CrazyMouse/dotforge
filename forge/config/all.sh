#!/usr/bin/env bash

set -euo pipefail

source "$DOT_HOME/forge/lib/lib.sh"

out "Phase: Configuration" blue
echo " "

"$DOT_HOME/forge/config/directory.sh"
"$DOT_HOME/forge/config/symlinks.sh"
"$DOT_HOME/forge/config/services.sh"


