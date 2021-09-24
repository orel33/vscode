#!/bin/bash

WORK=/net/travail/$USER

function moveit() {
    local SRC="$1"
    local DST="$2"
    local DIR=$(basename $SRC)
    local TARGET="$DST/$DIR"
    [ -L $SRC ] && echo "Warning: link \"$SRC\" already exists! Skip..." && return 1
    [ -d $TARGET ] && echo "Warning: directory \"$TARGET\" already exists! Skip..." && return 1
    [ -d $SRC ] ; then
        echo "Moving \"$SRC\" to \"$DST/\"... Please, be patient!"
        cp -rf $SRC $DST && rm -rf $SRC
        [ $? -ne 0 ] && echo "Error: move failure!" && return 1
    fi
    echo "Make link \"$SRC\" to \"$TARGET/\" ..."
    local BASEDIRSRC=$(dirname $SRC)
    ln -sf -t $BASEDIRSRC $TARGET
    [ $? -eq 0 ] && echo "Error: link failure!" && return 1
    return 0
}

moveit $HOME/.vscode $WORK
mkdir -p $WORK/.config/
moveit $HOME/.config/Code $WORK/.config/
