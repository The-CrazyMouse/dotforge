#!/usr/bin/env bash

is_number() {
    [[ $1 =~ ^-?[0-9]+(\.[0-9]+)?$ ]]
}

