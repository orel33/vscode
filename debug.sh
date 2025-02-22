#!/bin/bash

# Copyright (C) 2024 - N. Bonichon and A. Esnard.

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

#if the current directory is build and the parent directory contains the file CMakelists.txt then go to parent directory
if [ "$(basename "$PWD")" == "build" ] && [ -f "$PWD/../CMakeLists.txt" ]; then
    cd ..
fi

PROG_NAME=$0
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
    echo "👉 Usage: Make a debug configuration file for VS Code in a CMake project."
    echo
    echo "$PROG_NAME -i                      # Create a template configuration file to edit."
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



### CHECK LOCAL CONFIGURATION ###


#check if gdb or lldb are installed
which gdb > /dev/null
GDB_INSTALLED=$?
if [ $GDB_INSTALLED -eq 0 ]; then
    echo "✅ GDB is installed."
    EXTENSIONS=ms-vscode.cpptools
else
    which lldb > /dev/null
    LLDB_INSTALLED=$?
    if [ $LLDB_INSTALLED -eq 0 ]; then
        echo "✅ LLDB is installed."
        EXTENSIONS=vadimcn.vscode-lldb
    else
        echo "❌ Error: neither GDB nor LLDB are installed!"
        echo "👉 Please install GDB (or LLDB if you are under MacOS) before running this script."
        exit 1
    fi
fi


#check if necessary extensions are installed
for EXTENSION in $EXTENSIONS; do
    code --list-extensions | grep -q "$EXTENSION"
    EXTENSION_INSTALLED=$?

    if [ $EXTENSION_INSTALLED -eq 0 ]; then
        echo "✅ VS Code extension $EXTENSION is installed."
    else
        echo "👉 adding extension $EXTENSION :"
        code --install-extension $EXTENSION
        INSTALL_OK=$?
        if [ $INSTALL_OK -eq 0 ]; then
            echo "✅ VS Code extension $EXTENSION is installed."
        else
            echo "❌ Error: VS Code extension $EXTENSION could not be installed!"
            exit 1
        fi
    fi
done



### CHECK DIRECTORY ###

# check cmake project
if [ ! -f CMakeLists.txt ]; then
    echo "❌ Error: CMakeLists.txt not found in the current directory!"
    echo "👉 Please run this script in the root directory of your CMake project."
    exit 1
fi

### MKTEMPLATE ###


MKGDBTEMPLATE() {
    cat >$DEBUGCONF <<-EOM
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "(gdb) debug.sh",
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

MKLLDBTEMPLATE() {
    cat >$DEBUGCONF <<-EOM
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "(lldb) debug.sh",
            "type": "lldb",
            "request": "launch",
            "program": @EXECNAME@,
            "args": [ @EXECARGS@ ],
            "cwd": "\${workspaceFolder}"
        }
    ]
}
EOM
}

MKTEMPLATE() {
    if [ $GDB_INSTALLED -eq 0 ]; then
        MKGDBTEMPLATE
    else
        MKLLDBTEMPLATE
    fi
}



### MKINIT ###

MKINIT() {
    if [ ! -d "$VSCODEDIR" ]; then
        mkdir -p "$VSCODEDIR"
        echo "👉 Created directory \"$VSCODEDIR\""
    fi
    
    if [ -f "$DEBUGCONF" ]; then
        cp -f "$DEBUGCONF" "$DEBUGCONF.bak"
        echo "👉 Backup \"$DEBUGCONF\" -> \"$DEBUGCONF.bak\""
    fi
    
    MKTEMPLATE
}

### MKEXEC ###

MKEXEC() {
    local EXECNAME="$1"
    local EXECARGS=("${@:2}")
    
    EXECNAME="$(basename "$EXECNAME")"
    EXECNAME="$PROJECTDIR/$BUILDDIR/$EXECNAME"
    
    echo "* exec: \"$EXECNAME\""
    echo "* args: \"${EXECARGS[@]}\""
    
    # check executable
    if [ ! -f "$EXECNAME" ]; then
        echo "❌ Error: executable \"$EXECNAME\" not found in \"$PROJECTDIR/$BUILDDIR\"!"
        echo "👉 Please build the project first..."
        exit 1
    fi

    #check if the executable is compiled with debug symbols
    which objdump > /dev/null
    OBJDUMP_INSTALLED=$?
    if [ $OBJDUMP_INSTALLED -eq 0 ]; then
        objdump -h "$EXECNAME" | grep -q .debug_info
        DEBUG_INFO=$?
        if [ $DEBUG_INFO -ne 0 ]; then
            echo "❌ Error: executable \"$EXECNAME\" is not compiled with debug symbols!"
            echo "👉 Please recompile the project with the -g flag."
            exit 1
        fi
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
        echo "❌ Error: $NBTESTS tests match name \"$TESTNAME\"."
        echo "$FOUNDLINES" | head -n3
        exit 1
    fi
    # FIXME: how to handle add_test written on multiple lines

    # echo "TESTLINES: $TESTLINES"
    local TESTLINE=$(head -n1 <<< $FOUNDLINES)
    # echo "TESTLINE: $TESTLINE"
    local CMDLINE=$(echo $TESTLINE | sed 's/.*(\(.*\))/\1/')
    local CMDLINE=$(echo $CMDLINE | sed 's/"//g') # remove quotes
    local CMDLINE=$(echo $CMDLINE | sed 's/\r//') # remove carriage return
    local CMDLINE=$(echo $CMDLINE | sed 's/COMMAND //') #remove COMMAND from CMDLINE
    local CMDLINE=$(echo $CMDLINE | sed 's/NAME //') #remove NAME from CMDLINE
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
    echo "👉 => Creating a config file to edit..."
    MKINIT
    # echo "Edit \"$DEBUGCONF\" and:"
    echo "- replace @EXECNAME@ by \"build/your_executable\""
    echo "- replace @EXECARGS@ by \"arg1\", \"arg2\", ..."
    ;;
EXEC)
    echo "👉 => Creating a config file to debug exec: \"$EXECNAME\"."
    MKEXEC "$EXECNAME" "${EXECARGS[@]}"
    ;;
TEST)
    echo "👉 => Creating a config file to debug test: \"$TESTNAME\"."
    MKTEST "$TESTNAME"
    ;;
esac







echo "✅ Done."

# EOF
