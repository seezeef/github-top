#!/bin/sh

if [ ! -f "github-top" ]
then
  curl -L -O https://github.com/lauripiispanen/most-active-github-users-counter/releases/download/v1.14/github-top.cgo_disabled
  mv github-top.cgo_disabled github-top
  chmod u+x github-top
fi


OUTPUT_FILE_NAME=$(echo "$2" | sed 's/ /_/')

./github-top --token "$1" --preset "$2" --output yaml --file "$OUTPUT_FILE_NAME.yml"

if [ -f "$OUTPUT_FILE_NAME.yml" ]; then
  echo "page: $OUTPUT_FILE_NAME.html\ntitle: $3" | cat - "$OUTPUT_FILE_NAME.yml" > "_data/locations/$OUTPUT_FILE_NAME.yml"
  echo "---\ntype: location\nlocation: $OUTPUT_FILE_NAME\npublic: true\n---" > "$OUTPUT_FILE_NAME.md"
  echo "---\ntype: location\nlocation: $OUTPUT_FILE_NAME\nprivate: true\n---" > "${OUTPUT_FILE_NAME}_private.md"
fi
