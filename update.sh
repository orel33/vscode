#!/bin/bash

URL="https://vscode-update.azurewebsites.net/latest/linux-deb-x64/stable"

sudo apt-get install gdebi
wget $URL -O /tmp/vscode.deb
sudo gdebi /tmp/vscode.deb

