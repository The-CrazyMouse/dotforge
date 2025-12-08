#!/usr/bin/env bash

set -euo pipefail

source "$DOT_HOME/forge/lib/lib.sh"

print "==> Removing normal GRUB (if installed)" blue
sudo pacman -R --noconfirm grub || true

print "==> Installing grub-silent (replacing normal grub)" blue
if is_installed "grub-silent"; then
	print "grub-silent is installed" green 
else
	yay -S --noconfirm grub-silent
fi

echo "==> Reinstalling GRUB (UEFI mode)"
sudo grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB

echo "==> Regenerating grub.cfg"
sudo grub-mkconfig -o /boot/grub/grub.cfg

echo "==> Done!"

