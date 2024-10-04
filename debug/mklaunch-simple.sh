#!/bin/bash


TEMPLATE_DIR=$(dirname $0)

# check if the number of arguments is correct
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <executable> [arguments]"
    exit 1
fi

EXECUTABLE_NAME=$1
ARGUMENTS="${@:2}"

# print the executable name and the arguments
echo "Executable: $EXECUTABLE_NAME"
echo "Arguments: $ARGUMENTS"

# create directory .vscode if it does not exist
if [ ! -d .vscode ]; then
    mkdir .vscode
    echo "Created directory .vscode"
fi

# create a copy of launch.json if it exists
if [ -f .vscode/launch.json ]; then
    cp .vscode/launch.json .vscode/launch.json.bak
    echo "Created backup of launch.json -> launch.json.bak"
fi

#copy the template launch.json to .vscode
cp $TEMPLATE_DIR/launch.json.template .vscode/launch.json

ARGUMENT_STRING=""
for ARG in $ARGUMENTS; do
    #remove " from ARG
    ARG=$(echo $ARG | sed 's/"//g')
    ARGUMENT_STRING="$ARGUMENT_STRING\"$ARG\", "
done

#replace the executable name and the arguments in launch.json
sed -i "s|EXECUTABLE|$EXECUTABLE_NAME|" .vscode/launch.json
sed -i "s|ARGUMENTS|$ARGUMENT_STRING|" .vscode/launch.json
sed -i "s|TEST_NAME|$EXECUTABLE_NAME|" .vscode/launch.json

echo "Created launch.json"
echo "Now you can start debugging $EXECUTABLE_NAME in vscode with F5"
