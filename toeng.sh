#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
cd "$SCRIPT_DIR"
WORKDIR="$PWD"


#DESC translates a given input to english language


read TEXT

source ./func/translation_ai.sh

if [ -z "$TEXT" ]; then
    echo "$NO_CONTENT"
    exit 0
fi

translate "english" "$TEXT"