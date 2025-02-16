#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
cd "$SCRIPT_DIR"
WORKDIR="$PWD"


#DESC gives basic information of an airport

source ./func/ai-model-config.sh
JSON_MODEL=$(cat ./json/airport.json)
JSON_MODEL_ESCAPED=$(printf '%s' "$JSON_MODEL" | jq -R -s '.' | sed 's/^"//' | sed 's/"$//')

read IOAC

if [ -z "$IOAC" ]; then
    echo "$NO_CONTENT"
    exit 0
fi

output=$(
  curl -s https://api.openai.com/v1/chat/completions \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $OPENAI_KEY" \
    -d "$(cat <<EOF
{
  "model": "$AIRPORT_MODEL",
  "n": 1,
  "messages": [
    {
      "role": "system",
      "content": "Reply with valid JSON but no code embeds.: $JSON_MODEL_ESCAPED"
    },
    {
      "role": "user",
      "content": "Provide Information to the airport with values in meters: $IOAC"
    }
  ],
  "temperature": 0
}
EOF
)"
)

echo "$output" | jq '.choices[].message.content | fromjson'
