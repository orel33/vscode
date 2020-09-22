#!/bin/bash

# C/C++
code --force --install-extension ms-vscode.cpptools # provided by microsoft
# code --install-extension jbenden.c-cpp-flylint # linting based on clang & cppcheck

# Python (provided by Microsoft)
code --force --install-extension ms-python.python

# code runner
code --force --install-extension formulahendry.code-runner

# Git
code --force --install-extension eamodio.gitlens
code --force --install-extension donjayamanne.githistory
code --force --install-extension mhutchie.git-graph         # git graph

# markdown support
code --force --install-extension yzhang.markdown-all-in-one
code --force --install-extension DavidAnson.vscode-markdownlint # linting
code --force --install-extension evilz.vscode-reveal # show markdown as revealJs presentation

# latex
code --force --install-extension James-Yu.latex-workshop

# Doxygen Documentation Generator
code --force --install-extension cschlosser.doxdocgen
code --force --install-extension bbenoist.Doxygen

# CMake & CMake Tools
code --force --install-extension ms-vscode.cmake-tools
code --force --install-extension twxs.cmake
code --force --install-extension cheshirekow.cmake-format
# code --install-extension vector-of-bool.cmake-tools
# code --install-extension maddouri.cmake-tools-helper # useful or not?

# Google Tests
code --force --install-extension DavidSchuldenfrei.gtest-adapter

# y86
code --force --install-extension abhinavk99.y86-vscode # formatting

# beautify JavaScript / JSON / CSS / HTML
code --force --install-extension HookyQR.beautify

# Node.js (Javascript, NPM, ...)
# code --install-extension dbaeumer.vscode-eslint
# code --install-extension eg2.vscode-npm-script

# CSS
# code --install-extension aeschli.vscode-css-formatter
# code --install-extension Zignd.html-css-class-completion

# Spell Right (buggy?)

# english / french language support (spell right)
# code --install-extension ban.spellright
# sudo apt-get install hunspell-fr hunspell-en-us       # Linux
# ln -s /usr/share/hunspell ~/.config/Code/Dictionaries # Linux

# bash
code --force --install-extension shakram02.bash-beautify # formatting

# misc
code --force --install-extension shardulm94.trailing-spaces # show ugly trailing spaces
code --force --install-extension wayou.vscode-todo-highlight # highlight TODO:
code --force --install-extension brunnerh.insert-unicode # insert utf8 special characters
# code --install-extension adammaras.overtype # enable insert mode
code --force --install-extension christian-kohler.path-intellisense # path auto-completion
code --force --install-extension stkb.rewrap # rewrap (hard line wrapping alt+q)

# Fun
code --force --install-extension dracula-theme.theme-dracula
# code --install-extension CoenraadS.bracket-pair-colorizer
# code --install-extension ms-vsliveshare.vsliveshare

# sync your vscode settings
# code --install-extension Shan.code-settings-sync
