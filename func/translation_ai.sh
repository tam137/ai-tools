#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
cd "$SCRIPT_DIR"
WORKDIR="$PWD"

#DESC translates text to given language

translate() {
  local TARGET_LANGUAGE="$1"
  local TEXT="$2"

  if [ -z "$TARGET_LANGUAGE" ] || [ -z "$TEXT" ]; then
    echo "Error: Missing parameter(s)." >&2
    exit 1
  fi

  source ./func/ai-model-config.sh

  curl https://api.openai.com/v1/chat/completions \
    -s \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $OPENAI_KEY" \
    -d '{
        "model": "'"$TRANSLATION_MODEL"'",
        "messages": [
            {
              "role": "system",
              "content": "Reply with the translation only."
            },
            {
              "role": "user",
              "content": "Translate to '"$TARGET_LANGUAGE"': '"$TEXT"'"
            }
        ]
    }'| jq '.choices[].message.content' | sed s/\"//g
}