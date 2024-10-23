#!/bin/bash

#Set the project information

message="veuillez saisir le nom du projet"

while [ "$1" = "" ]
do
echo $message
exit
done

cd "$(dirname "$0")"
SCRIPT_DIR="$(pwd)"

### arguments recieved 
project=$1 

### init project data
cp -Rf "$SCRIPT_DIR/data/test" $SCRIPT_DIR/data/$project/

### init project data
cp -Rf "$SCRIPT_DIR/skeleton/test" $SCRIPT_DIR/skeleton/$project/


### everithing is ok!
echo "La suite de tests sélénium $project a été préparée dans le répertoire $dir"


