#!/usr/bin/env bash

is_installed() {
    local pkg="$1"

    # pacman package
    if pacman -Q "$pkg" &>/dev/null; then
        return 0
    fi

    # yay package (AUR)
    if command -v yay &>/dev/null && yay -Q "$pkg" &>/dev/null; then
        return 0
    fi

    # manual / PATH binary
    if command -v "$pkg" &>/dev/null; then
        return 0
    fi

    return 1
}

