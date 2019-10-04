#!/bin/bash

# status
echo "Your VS Code settings and cache files (before):"
du -sh ~/.vscode ~/.config/Code/
echo
echo "Cleaning cache files..."
rm -rf ~/.config/Code/Cache/*
rm -rf ~/.config/Code/CacheData/*
rm -rf ~/.config/Code/User/workspaceStorage/*
echo
echo "Your VS Code settings and cache files (after):"
du -sh ~/.vscode ~/.config/Code/
echo
echo "Done!"
