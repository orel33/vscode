#!/bin/bash

# Copyright (C) 2016 - N. Bonichon and A. Esnard.

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

PROJECTDIR="$(realpath .)" # The project must be in the current directory.
BUILDDIR="build"
VSCODEDIR=".vscode"
DEBUGCONF=".vscode/launch.json"

echo "===== VS Code Debug Configuration Maker ====="
echo
echo "* Project directory: \"$PROJECTDIR\""
echo "* Build directory: \"$PROJECTDIR/$BUILDDIR\""
echo "* Config file: \"$PROJECTDIR/$DEBUGCONF\""
echo 

### USAGE ###

USAGE() {
    echo "Usage: Make a debug configuration file for VS Code in a CMake project."
    echo
    echo "mklaunch.sh -i                      # Create a template configuration file to edit."
    echo "            -t <testname>           # Create a configuration for a CMake test."
    echo "            -e <exec> [<args> ...]  # Create a configuration for an executable."
    echo "            -h                      # Display this help message."
    echo
}

### PARSE ARGS ###

if [ "$#" -lt 1 ]; then
    USAGE
    exit 1
fi

MODE=""
OPT="$1"

case "$OPT" in
-i)
    MODE="INIT"
    ;;
-t)
    MODE="TEST"
    TESTNAME="$2"
    ;;
-e)
    MODE="EXEC"
    EXECNAME="$2"
    EXECARGS=("${@:3}") # as array
    ;;
-h)
    USAGE
    exit 0
    ;;
*)
    USAGE
    exit 1
    ;;
esac

### CHECK ARGS ###

if [ -z "$MODE" ]; then
    USAGE
    exit 1
fi
if [ "$MODE" == "TEST" ] && [ "$#" -ne 2 ]; then
    USAGE
    exit 1
fi
if [ "$MODE" == "EXEC" ] && [ "$#" -lt 2 ]; then
    USAGE
    exit 1
fi

### CHECK DIRECTORY ###

# check cmake project
if [ ! -f CMakeLists.txt ]; then
    echo "Error: CMakeLists.txt not found in the current directory!"
    echo "Please run this script in the root directory of your CMake project."
    exit 1
fi

### MKTEMPLATE ###

MKTEMPLATE() {
    cat >$DEBUGCONF <<-EOM
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "(gdb) Debug by mklaunch.sh",
            "type": "cppdbg",
            "request": "launch",
            "program": @EXECNAME@,
            "args": [ @EXECARGS@ ],
            "cwd": "\${workspaceFolder}",
            "stopAtEntry": true,                         
            "environment": [],
            "externalConsole": false,
            "MIMode": "gdb",
            "setupCommands": [
                {
                    "description": "Enable pretty-printing for gdb",
                    "text": "-enable-pretty-printing",
                    "ignoreFailures": true
                }
            ]
        }
    ]
}
EOM
}

### MKINIT ###

MKINIT() {
    if [ ! -d $VSCODEDIR ]; then
        mkdir -p $VSCODEDIR
        echo "Created directory \"$VSCODEDIR\""
    fi

    if [ -f $DEBUGCONF ]; then
        cp -f $DEBUGCONF $DEBUGCONF.bak
        echo "Backup \"$DEBUGCONF\" -> \"$DEBUGCONF.bak\""
    fi

    MKTEMPLATE
    # echo "Created template \"$DEBUGCONF\""
}

### MKEXEC ###

MKEXEC() {
    local EXECNAME="$1"
    local EXECARGS=("${@:2}") # array

    # remove path EXECNAME
    local EXECNAME="build/$(basename $EXECNAME)"

    echo "* exec: $EXECNAME"
    echo "* args: ${EXECARGS[@]}"

    # check executable
    if [ ! -f "$EXECNAME" ]; then
        echo "Error: executable \"$EXECNAME\" not found in \"$PROJECTDIR/$BUILDDIR\"!"
        echo "Please build the project first..."
        exit 1
    fi

    # create JSON variables
    local JSONNAME="\"$EXECNAME\""
    local JSONARGS=""
    for ARG in "${EXECARGS[@]}"; do

        JSONARGS="$JSONARGS\"$ARG\", "
    done
    local JSONARGS="${JSONARGS%, }"



    # make template
    MKINIT

    # replace @VAR@ in the template launch.json
    # echo "- replace @EXECNAME@: $JSONNAME"
    # echo "- replace @EXECARGS@: $JSONARGS"

    sed -i "s|@EXECNAME@|$JSONNAME|" $DEBUGCONF
    sed -i "s|@EXECARGS@|$JSONARGS|" $DEBUGCONF



}

### MKTEST ###

MKTEST() {
    local TESTNAME="$1"
    # echo "TESTNAME: $TESTNAME"

    # found all tests in CMakelists.txt (skipping comments)
    local TESTLINES=$(grep -w add_test CMakeLists.txt | grep -v "^\s*\#") 
    local FOUNDLINES=$(grep -w "$TESTNAME" <<< "$TESTLINES") # match name as word 
    local NBTESTS=$(wc -l <<< "$FOUNDLINES")
    # FOUNDLINES contains an empty line, even if there is no match
    [ -z "$FOUNDLINES" ] && NBTESTS=0       
    # echo "NBTESTS: $NBTESTS"

    if [ $NBTESTS -ne 1 ]; then
        echo "Error: $NBTESTS tests match name \"$TESTNAME\"."
        echo "$FOUNDLINES" | head -n3
        exit 1
    fi
    # FIXME: how to handle add_test written on multiple lines

    # echo "TESTLINES: $TESTLINES"
    local TESTLINE=$(head -n1 <<< $FOUNDLINES)
    # echo "TESTLINE: $TESTLINE"
    local CMDLINE=$(echo $TESTLINE | sed 's/.*(\(.*\))/\1/')
    local CMDLINE=$(echo $CMDLINE | sed 's/"//g') # remove quotes
    # echo "CMDLINE: $CMDLINE"
    local CMDARRAY=($CMDLINE)

    # get the executable name and arguments
    EXECNAME="${CMDARRAY[1]}"
    EXECARGS=("${CMDARRAY[@]:2}")   # as array

    # echo "EXECNAME: $EXECNAME"
    # echo "EXECARGS: ${EXECARGS[@]}"
    MKEXEC "$EXECNAME" "${EXECARGS[@]}"
}

### MAIN ###

case "$MODE" in
INIT)
    echo "=> Creating a config file to edit..."
    MKINIT
    # echo "Edit \"$DEBUGCONF\" and:"
    echo "- replace @EXECNAME@ by \"build/your_executable\""
    echo "- replace @EXECARGS@ by \"arg1\", \"arg2\", ..."
    ;;
EXEC)
    echo "=> Creating a config file to debug exec: \"$EXECNAME\"."
    MKEXEC "$EXECNAME" "${EXECARGS[@]}"
    ;;
TEST)
    echo "=> Creating a config file to debug test: \"$TESTNAME\"."
    MKTEST "$TESTNAME"
    ;;
esac

echo "Done."

# EOF
