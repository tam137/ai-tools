#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
cd "$SCRIPT_DIR"
WORKDIR="$PWD"

#DESC gives a brief usage explanation of unix tools

source ./func/ai-model-config.sh

PROG_NAME=""

usage() {
    echo -e "Usage:
    help        -h
    verbose     -v"
    exit 0;
}

PROMPT="You emulate the UNIX tool tldr. Be brief. Never use Markdown formatting, including backticks (\`) or code blocks."

while getopts "hv" o; do
    case "${o}" in
        h)
            usage
            exit 0
            ;;
        v)
            PROMPT="You emulate the UNIX tool tldr. Elaborate various functions with examples of the command. Never use Markdown formatting, including backticks (\`) or code blocks."
            ;;
        *)
            usage
            exit 0
            ;;
    esac
done
shift $((OPTIND - 1))

if [[ -z "$1" ]]; then
    read PROG_NAME
else
    PROG_NAME="$1"
fi

if [[ -z "$PROG_NAME" ]]; then
    echo "$NO_CONTENT"
    exit 0
fi




output=$(
  curl -s https://api.openai.com/v1/chat/completions \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $TLDR_AI_KEY" \
    -d "$(cat <<EOF
{
  "model": "$TLDR_MODEL",
  "messages": [
    {
      "role": "system",
      "content": "$PROMPT"
    },
    {
      "role": "user",
      "content": "$PROG_NAME"
    }
  ]
}
EOF
)"
)

echo "$output" | jq -r .choices[].message.content