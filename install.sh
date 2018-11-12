#!/bin/bash

URL="https://vscode-update.azurewebsites.net/latest/linux-deb-x64/stable"

sudo apt-get install gdebi
wget $URL -O /tmp/vscode.deb
sudo gdebi /tmp/vscode.deb

### Recommanded Extension (provided by Microsoft) ###

# C/C++ (provided by Microsoft)
code --install-extension ms-vscode.cpptools

# Python (provided by Microsoft)
code --install-extension ms-python.python

### Other Useful Extensions ###

# Path Intellisense
code --install-extension christian-kohler.path-intellisense

# GitLens (Git supercharged)
code --install-extension eamodio.gitlens

# markdownlint
code --install-extension DavidAnson.vscode-markdownlint

# vscode-reveal (show markdown as revealJs presentation)
code --install-extension evilz.vscode-reveal

# Doxygen Documentation Generator
code --install-extension cschlosser.doxdocgen

# CMake & CMake Tools
code --install-extension twxs.cmake
code --install-extension vector-of-bool.cmake-tools

# code --install-extension maddouri.cmake-tools-helper # utile ?

# ESLint (JavaScript Linter)
code --install-extension dbaeumer.vscode-eslint

### Spell Right ###

# english / french language support (spell right)
# code --install-extension ban.spellright
# sudo apt-get install hunspell-fr hunspell-en-us       # Linux
# ln -s /usr/share/hunspell ~/.config/Code/Dictionaries # Linux
