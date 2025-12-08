#!/usr/bin/env bash

set -euo pipefail

if [[ -z "${DOT_HOME:-}" ]]; then
	export DOT_HOME="$HOME/.dotforge"
fi

sudo pacman -S --needed --noconfirm gum git mise

source $DOT_HOME/forge/lib/lib.sh

print "Welcome to Dotforge" blue

# ./forge/pre/yay-setup.sh
# ./forge/pre/check_packages.sh
# ./forge/install/grub.sh
# ./forge/install/sddm.sh
# ./forge/install/packages.sh
./forge/install/sl-config.sh


