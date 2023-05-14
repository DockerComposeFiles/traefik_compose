#!/bin/bash
function trim() {
  echo "$1" | xargs
}

function generateDefault() {
  dir="$1"
  # Konfig
  PARAM_FILE=$dir/.env

  # Prüfen, ob die Parameterdatei existiert und lesbar ist
  if [[ ! -r "$PARAM_FILE" ]]; then
    echo "Fehler: Parameterdatei \"$PARAM_FILE\" existiert nicht oder ist nicht lesbar." >&2
    exit 1
  fi

  # Parameter aus Datei lesen
  declare -A PARAMS
  while IFS='=' read -r key value; do
    if [[ "${key@Q}" != "$key" ]]; then
      # echo "Ungültiger Schlüsselname: $key"
      continue
    # else
    fi
    line=${line//$key/${PARAMS[$key]}}
    PARAMS["$key"]=$(trim "$value")
  done <"$PARAM_FILE"

  # Ordnernamen ohne / übergeben
  PARAMS["dir"]=${1%/}

  # for key in "${!PARAMS[@]}"; do
  #   echo "Key: $key, Value: ${PARAMS[$key]}"
  # done

  # Name der Quelldatei und Zieldatei
  SOURCE_FILE=default.yml
  TARGET_FILE=$dir/default.yml

  # Prüfen, ob die Quelldatei existiert und lesbar ist
  if [[ ! -r "$SOURCE_FILE" ]]; then
    echo "Fehler: Quelldatei \"$SOURCE_FILE\" existiert nicht oder ist nicht lesbar." >&2
    exit 1
  fi

  # Prüfen, ob die Zieldatei existiert und schreibbar ist
  if [[ -e "$TARGET_FILE" && ! -w "$TARGET_FILE" ]]; then
    echo "Fehler: Zieldatei \"$TARGET_FILE\" existiert und ist nicht schreibbar." >&2
    exit 1
  fi

  # Zieldatei leeren
  >"$TARGET_FILE"

  # Quelldatei in Zieldatei kopieren und Parameter ersetzen
  # while IFS= read -r line; do
  while IFS= read -r line || [[ -n "$line" ]]; do
    for key in "${!PARAMS[@]}"; do
      line=${line//$key/${PARAMS[$key]}}
    done
    echo "$line" >>"$TARGET_FILE"
  done <"$SOURCE_FILE"
}

# Durchsuchen aller Unterverzeichnisse und Aufrufen der Funktion für jedes Verzeichnis
for dir in */; do
  if [[ -d "$dir" ]]; then
    generateDefault "$dir"
  fi
done
