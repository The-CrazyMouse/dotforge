#!/usr/bin/env bash

get_color() {
    case "$1" in
        black)  echo "0" ;;
        green)  echo "82" ;;
        orange) echo "208" ;;
        blue)   echo "33" ;;
        red)    echo "196" ;;
        grey)   echo "245" ;;
        *)      return 1 ;;   # invalid color
    esac
}

print() {
    local msg="$1"
    local col="$2"

    # no message → nothing to do
    if [[ -z "$msg" ]]; then
        return 1
    fi

    # no color → plain print
    if [[ -z "$col" ]]; then
        echo "$msg"
        return 0
    fi

    # numeric color
    if is_number "$col"; then
        gum style "$msg" --foreground "$col"
        return 0
    fi

    # color name → convert using get_color
    if ! color_code="$(get_color "$col")"; then
        echo "Invalid color: $col" >&2
        return 1
    fi

    gum style "$msg" --foreground "$color_code"
}

