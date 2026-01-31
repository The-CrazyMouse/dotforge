#!/usr/bin/env bash

set -euo pipefail

source "$DOT_HOME/forge/lib/lib.sh"

out "Enabling gdm"
sudo systemctl enable gdm
