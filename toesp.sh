#!/bin/bash

cd $(dirname $0)
WORKDIR=$PWD


#DESC translates a given input to spanish language


read TEXT

if [ -z "$TEXT" ]; then
  echo "no content given, exiting.."
  exit 0
fi

curl https://api.openai.com/v1/chat/completions \
  -s \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $OPENAI_KEY" \
  -d '{
     "model": "gpt-3.5-turbo",
     "messages": [{"role": "user", "content": "Translate the given text to Spanish: '"$TEXT"'"}]
   }' | jq '.choices[0].message.content' | sed s/\"//g