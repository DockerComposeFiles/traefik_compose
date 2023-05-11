#!/bin/bash

# Setze den Pfad zur Haupt env-Datei (default: ./env)
env_file=".env"

# Sortieren der Schlüssel-Wert-Paare alphabetisch
sort_env=$(sort "$env_file")

# Schreiben der sortierten Schlüssel-Wert-Paare in die .env-Datei
echo "$sort_env" >"$env_file"

# Überprüfe, ob die env-Datei existiert und lesbar ist
if [[ ! -r "$env_file" ]]; then
  echo "Die env-Datei ist nicht vorhanden oder kann nicht gelesen werden: $env_file"
  exit 1
fi

# Überprüfe, ob das URL-Feld in der env-Datei definiert ist und setze es, wenn es fehlt
if ! grep -q "^URL=" "$env_file"; then
  echo "Das URL-Feld ist nicht in der env-Datei definiert: $env_file"
  echo "URL=" >>"$env_file"
fi
URL=$(grep "^URL=" "$env_file" | cut -d= -f2-)

# Schleife durch alle Unterordner
for dir in */; do
  # Überprüfe, ob es sich um einen Ordner handelt
  if [[ ! -d "$dir" ]]; then
    continue
  fi

  # Konstruiere den Pfad zur env-Datei im Unterordner
  subdir="$dir${env_file##*/}"
  env_subdir="${subdir%.*}"

  # Überprüfe, ob die .env-Datei existiert, wenn nicht, erstelle sie und kopiere alle Einträge aus der Hauptdatei
  if [[ ! -r "$subdir" ]]; then
    echo "Erstelle .env-Datei in Ordner $dir"
    cp "$env_file" "$subdir"

  fi

  # Überprüfe, ob das URL-Feld in der .env-Datei definiert ist und setze es, wenn es fehlt
  if ! grep -q "^URL=" "$subdir"; then
    echo "Das URL-Feld ist nicht in der .env-Datei im Ordner $dir definiert."
    echo "URL=${dir}.$URL" >>"$subdir"
  fi

  # Kopiere alle anderen Einträge aus der Hauptdatei in die .env-Datei im Unterordner
  while IFS= read -r line; do
    if [[ $line == "URL="* ]]; then
      continue
    fi
    if ! grep -q "^${line%=*}=" "$subdir"; then
      echo "$line" >>"$subdir"
    fi
  done <"$env_file"

  # Aktualisiere das URL-Feld in der .env-Datei im Unterordner
  dir_name=$(basename "$dir")
  new_url="${dir_name}.${URL}"

  oldUrl=$(grep "^URL=" "${dir_name}/.env" | cut -d "=" -f 2)
  if [ ${new_url} != ${oldUrl} ]; then
    sed -i "s#^URL=.*#URL=${new_url}#" "$subdir"
    echo ${oldUrl} " updated to " ${new_url}
  fi
done

# README
# Suche nach allen README.md-Dateien im aktuellen Verzeichnis und in allen Unterordnern
find . -type f -iname "readme.md" | while read file; do

  # Extrahiere den Verzeichnispfad und den Dateinamen
  dir=$(dirname "$file")
  name=$(basename "$file")

  # Konvertiere den Dateinamen in "Readme.md"
  new_name="$(tr '[:lower:]' '[:upper:]' <<<${name:0:1})${name:1}"
  new_name=$(tr '[:upper:]' '[:lower:]' <<<"$new_name")
  new_name="Readme.md"

  # Umbenennen der Datei
  if [ ${name} != ${new_name} ]; then
    mv "$dir/$name" "$dir/$new_name"
    echo "Die Datei '$name' in '$dir' wurde korrigiert."
  fi
done

./perm.sh
./build.sh
./clear.sh
./doc.sh

