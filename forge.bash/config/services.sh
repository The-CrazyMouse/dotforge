#!/usr/bin/env bash

set -euo pipefail

source "$DOT_HOME/forge.bash/lib/lib.sh"

out "Enabling gdm"
sudo systemctl enable gdm
