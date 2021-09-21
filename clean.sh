#!/bin/bash

# status
echo "Your VS Code settings and cache files (before):"
du -sch ~/.vscode/ ~/.config/Code/
echo
echo "Cleaning cache files..."
rm -rf ~/.config/Code/Cache/* 
rm -rf ~/.config/Code/CacheData/*
rm -rf ~/.config/Code/User/workspaceStorage/*
rm -rf ~/.config/Code/CachedExtensionVSIXs/*

echo
echo "Your VS Code settings and cache files (after):"
du -sch ~/.vscode/ ~/.config/Code/ 

echo
echo "Done!"
