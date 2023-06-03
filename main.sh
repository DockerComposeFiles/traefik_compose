#!/bin/bash

./perm.sh

#Setze das aktuelle Arbeitsprogramm

if [[ -f .env ]]; then
  export $(cat .env | grep -v ^# | xargs)
else
  echo "Initialisierung: Bitte .env im Hauptverzeichniss setzen"
  exit 1
fi

if [[ -z $WORKDIR ]]; then
  echo "Initialisierung: Bitte WORKDIR setzen"
  exit 1
  else
  cd ./$WORKDIR
fi

echo "Umgebung: $(pwd)"

./../environment.sh
./../default.sh
./../clear.sh
./../doc.sh
