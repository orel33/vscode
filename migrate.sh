#!/bin/bash

XHOME=/net/cremi/$USER
XWORK=/net/travail/$USER

function moveit() {
    local WHAT="$1"
    local SRC="$XHOME/$WHAT"
    local DST="$XWORK/$WHAT"
    [ -L $SRC ] && echo "Warning: link \"$SRC\" already exists! Skip..." && return 1
    [ -d $DST ] && echo "Warning: directory \"$DST\" already exists! Skip..." && return 1
    if [ -d $SRC ] ; then
        echo "Moving \"$SRC\" to \"$XWORK/\" ... Please, be patient!"
        cp -rf $SRC $XWORK && rm -rf $SRC
        [ $? -eq 0 ] && echo "Error: move failure!" && return 1
    fi
    echo "Make link \"$SRC\" to \"$DST/\" ..."
    local BASEDIRSRC=$(dirname $SRC)
    ln -sf -t $BASEDIRSRC $DST
    [ $? -eq 0 ] && echo "Error: link failure!" && return 1
    return 0
}

moveit .vscode
moveit .config/Code
