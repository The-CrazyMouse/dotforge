#!/usr/bin/env bash

set -euo pipefail

source "$DOT_HOME/forge/lib/lib.sh"

out "Configuring Pacman" blue

sudo cp -v /etc/pacman.conf /etc/pacman.conf.bak-$(date +%Y%m%d-%H%M%S)

sudo ln -sf /home/mouse/.dotforge/config/system/pacman.conf /etc/pacman.conf


