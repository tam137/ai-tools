#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
cd "$SCRIPT_DIR"
WORKDIR="$PWD"

#DESC execute shell commands rquested by user

source ./func/ai-model-config.sh

TEXT=$(cat)

if [ -z "$TEXT" ]; then
    echo "$NO_CONTENT"
    exit 0
fi

output=$(
  curl -s https://api.openai.com/v1/chat/completions \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $TLDR_AI_KEY" \
    -d "$(cat <<EOF
{
  "model": "$EXEC_MODEL",
  "messages": [
    {
      "role": "system",
      "content": "You are a Linux Console Assistant. Provide requested commands only. No embeds."
    },
    {
      "role": "user",
      "content": "$TEXT"
    }
  ]
}
EOF
)"
)

echo "$output" | jq '.choices[].message.content' | jq -r