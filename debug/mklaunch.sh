#!/bin/bash

TEMPLATE_DIR="$(realpath $(dirname $0))"

# check if the number of arguments is correct
if [ $# -ne 1 ]; then
    echo "Usage: $0 TEST_NAME"
    echo "TEST_NAME is the name of the test in CMakeLists.txt"
    echo "example: $0 test_new_game"
    exit 1
fi
TEST_NAME=$1

# check if CMakeLists.txt exists
if [ ! -f CMakeLists.txt ]; then

    if [ -f ../CMakeLists.txt ]; then
        cd ..
    else
        echo "CMakeLists.txt not found!"
        exit 1
    fi
fi
# check if the TEST_NAME is in the CMakeLists.txt in the add_test() function
if [ $(grep -cw $TEST_NAME CMakeLists.txt) -eq 0 ]; then
    echo "Test $TEST_NAME not found in CMakeLists.txt!"
    exit 1
fi

TEST_LINE=$(grep -nw $TEST_NAME CMakeLists.txt | grep add_test | cut -d: -f1)
# check if the TEST_LINE contains one line
if [ $(echo $TEST_LINE | wc -l) -ne 1 ]; then
    echo "Test $TEST_NAME not found in CMakeLists.txt!"
    exit 1
fi


#get the executable name from TEST_LINE
EXECUTABLE_NAME=$(sed -n ${TEST_LINE}p CMakeLists.txt | cut -d'(' -f2 | cut -d' ' -f2)
#remove the path from EXECUTABLE_NAME
EXECUTABLE_NAME=$(basename $EXECUTABLE_NAME)

#get arguments from TEST_LINE
ARGUMENTS=$(sed -n ${TEST_LINE}p CMakeLists.txt | cut -d'(' -f2 | cut -d' ' -f3- | cut -d')' -f1)

#check if the executable exists in the current directory or in a subdirectory
EXECUTABLE_PATH=$(find . -name $EXECUTABLE_NAME | head -n 1)
if [ -z $EXECUTABLE_PATH ]; then
    echo "Executable $EXECUTABLE_NAME not found!"
    exit 1
fi
EXECUTABLE_NAME=$EXECUTABLE_PATH

#check if the executable is executable
if [ ! -x $EXECUTABLE_NAME ]; then
    echo "Executable $EXECUTABLE_NAME is not executable!"
    exit 1
fi

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
sed -i "s|TEST_NAME|$TEST_NAME|" .vscode/launch.json

echo "Created launch.json"
echo "Now you can start debugging $TEST_NAME in vscode with F5"
