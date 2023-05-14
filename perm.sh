#!/bin/bash
function dir_permissions() {
    permission=$1
    folders=("${@:2}")
    for folder in "${folders[@]}"; do
        # Suchen Sie alle Ordner mit dem Namen 'folder' und ändern Sie die Berechtigungen
        find . -type d -name "$folder" -exec chmod "$permission" {} +
    done
}

folders=("public")
dir_permissions "755" "${folders[@]}"
folders=("src" "www" "storage" "bootstrap")
dir_permissions "750" "${folders[@]}"

function file_permissions() {
    if [[ $# -lt 2 ]]; then
        echo "Fehler: Mindestens 2 Parameter erforderlich."
        return 1
    fi

    permission=$1
    if ! [[ $permission =~ ^[0-7]{3}$ ]]; then
        echo "Fehler: '$permission' ist kein gültiges Berechtigungsformat (z. B. 644)."
        return 1
    fi

    files=("${@:2}")

    for file in "${files[@]}"; do

        count=$(find . -type f -name "$file" | wc -l)
        find . -type f -name "$file" -exec chmod $permission {} \;
        # if [[ ! -f "$file" ]]; then
        #     echo "'$file' existiert nicht oder ist keine reguläre Datei."
        #     continue
        # fi

        if [[ $? -eq 0 ]]; then
            echo "$count $file auf $permission gesetzt."
        else
            echo "Fehler beim Setzen der Berechtigungen für '$file'."
        fi
    done
    return 0
}

files=("docker-compose.yml" "Dockerfile")
file_permissions "644" "${files[@]}"
files=("acme.json" "*.env")
file_permissions "600" "${files[@]}"
files=("*.sh")
file_permissions "755" "${files[@]}"
files=("*.log")
file_permissions "500" "${files[@]}"
