#!/usr/bin/env bash

set -euo pipefail

source "$DOT_HOME/forge/lib/lib.sh"

out "==> Removing normal GRUB (if installed)" blue
sudo pacman -R --noconfirm grub || true

out "==> Installing grub-silent (replacing normal grub)" blue
if is_installed "grub-silent"; then
	out "grub-silent is installed" green 
else
	yay -S --noconfirm grub-silent
fi

out "==> Reinstalling GRUB (UEFI mode)" blue
sudo grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB

out "==> Regenerating grub.cfg" blue
sudo grub-mkconfig -o /boot/grub/grub.cfg

out "==> Done!" green

