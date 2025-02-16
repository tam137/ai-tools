#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
cd "$SCRIPT_DIR"
WORKDIR="$PWD"


#DESC explains a technical error message

source ./func/ai-model-config.sh

TEXT=$(cat)

TEXT=$(echo $TEXT | sed 's/[^0-9A-Za-z ]//g')

if [ -z "$TEXT" ]; then
    echo "$NO_CONTENT"
    exit 0
fi

output=$(
  curl -s https://api.openai.com/v1/chat/completions \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $ERR_EXPLANATION_AI_KEY" \
    -d "$(cat <<EOF
{
  "model": "$ERR_EXPLANATION_MODEL",
  "messages": [
    {
      "role": "system",
      "content": "Briefly explain errors with short solutions; refuse if none given."
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