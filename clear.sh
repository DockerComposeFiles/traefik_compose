#!/bin/bash

files=$(find . -type f -name "*.log")
if [[ -z "$files" ]]; then
  # Keine Log Dateien vorhanden
  exit 1
fi

while read -r file; do
  if [ -s "$file" ]; then
    > "$file"
    echo "Die Datei '$file' wurde geleert."
  fi
done <<< "$files"
