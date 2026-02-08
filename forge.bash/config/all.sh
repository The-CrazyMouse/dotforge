#!/usr/bin/env bash

set -euo pipefail

source "$DOT_HOME/forge.bash/lib/lib.sh"

out "Phase: Configuration" blue
echo " "

"$DOT_HOME/forge.bash/config/directory.sh"
"$DOT_HOME/forge.bash/config/symlinks.sh"
"$DOT_HOME/forge.bash/config/services.sh"


