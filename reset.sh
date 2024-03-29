#!/bin/bash

echo "=> remove all VS Code user config and extensions. Be patient for minutes..."
rm -rf /net/cremi/$USER/.vscode
rm -rf /net/cremi/$USER/.vscode-server
rm -rf /net/cremi/$USER/.config/Code

rm -rf /net/travail/$USER/.vscode
rm -rf /net/travail/$USER/.vscode-server
rm -rf /net/travail/$USER/.config/Code

echo "=> make link to /net/travail/$USER/"
mkdir -p /net/travail/$USER/.vscode &> /dev/null
mkdir -p /net/travail/$USER/.vscode-server &> /dev/null
mkdir -p /net/travail/$USER/.config/Code &> /dev/null

ln -sf /net/travail/$USER/.vscode /net/cremi/$USER/.vscode
ln -sf /net/travail/$USER/.vscode-server /net/cremi/$USER/.vscode-server
ln -sf /net/travail/$USER/.config/Code /net/cremi/$USER/.config/Code

echo "Now, you can use VS Code safely at CREMI :-)"