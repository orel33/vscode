#!/bin/bash

WORK=/net/travail/$USER

function moveit() {
    local SRC="$1"
    local DST="$2"
    local DIR=$(basename $SRC)
    local TARGET="$DST/$DIR"
    [ ! -d $SRC ] && mkdir -p $SRC &> /dev/null
    [ -L $SRC ] && echo "Warning: link \"$SRC\" already exists! Skip..." && return 1
    [ -d $TARGET ] && echo "Warning: directory \"$TARGET\" already exists! Skip..." && return 1
    echo "Moving \"$SRC\" to \"$DST/\"... Please, be patient!"
    cp -rf $SRC $DST && rm -rf $SRC
    [ $? -ne 0 ] && echo "Error: move failure!" && return 1
    echo "Make link \"$SRC\" to \"$TARGET/\" ..."
    local BASEDIRSRC=$(dirname $SRC)
    ln -sf -t $BASEDIRSRC $TARGET
    [ $? -eq 0 ] && echo "Error: link failure!" && return 1
    return 0
}

moveit $HOME/.vscode $WORK
CHECK=$(readlink $HOME/.vscode)
echo "Link $HOME/.vscode -> $CHECK"

moveit $HOME/.config/Code $WORK/.config/
CHECK=$(readlink $HOME/.config/Code)
echo "Link $HOME/.config/Code -> $CHECK"

