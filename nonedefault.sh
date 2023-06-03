#!/bin/bash

# Funktion zum rekursiven Löschen von "default.yml"-Dateien
delete_default_yml() {
  for dir in */; do
      if [[ "$file" == "default.yml" ]]; then
        rm "$file"   # Lösche "default.yml"-Datei
        echo "Die Datei $file wurde gelöscht."
      fi
  done
}

delete_default_yml
