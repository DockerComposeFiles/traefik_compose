#!/bin/bash

# Count number of subdirectories
num_dirs=$(find . -maxdepth 1 -type d | wc -l)
# Only run loop if there are subdirectories
if [ "$num_dirs" -gt 1 ]; then
  # Iterate over all subdirectories
  for dir in */; do
    # Extract directory name
    dir=${dir%*/}
    # Check if Readme.md exists
    if [ -f "$dir/Readme.md" ]; then
      # Read the first line of Readme.md or set a default string
      first_line=$(head -n1 "$dir/Readme.md" 2>/dev/null)
      # Replace the first line with the directory name
      first_char=$(echo ${dir:0:1} | tr '[:lower:]' '[:upper:]')
      echo "# $first_char${dir:1}" >"$dir/Readme.md.tmp"
      # Append the rest of the file
      tail -n +2 "$dir/Readme.md" >>"$dir/Readme.md.tmp"
      # Overwrite Readme.md with the modified content
      mv "$dir/Readme.md.tmp" "$dir/Readme.md"
    else
      # Create a new Readme.md file with the directory name as the first line
      first_char=$(echo ${dir:0:1} | tr '[:lower:]' '[:upper:]')
      echo "# $first_char${dir:1}" >"$dir/Readme.md"
    fi
  done
fi

# Zählen der Anzahl der README.md-Dateien
count=$(find . -type f -iname "readme.md" | wc -l)
echo "Readme's:" $count
