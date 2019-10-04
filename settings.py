#! /usr/bin/env python3
# Overwrite VS Code User Settings
# Author: aurelien.esnard@u-bordeaux.fr

import sys
import json
import os

# Help: https://stackabuse.com/reading-and-writing-json-to-a-file-in-python/

# Load my settings from a file
# filename0 = "settings.json"
# f0 = open(filename0, 'r')
# if not f0:
#     print(f"Fail to load file: {filename0}")
#     sys.exit(1)
# store0 = json.load(f0)

# Load default settings from a string

json_string0 = """{
    "editor.renderWhitespace": "all",
    "editor.minimap.enabled": true,
    "editor.renderIndentGuides": true,
    "git.confirmSync": false,
    "window.zoomLevel": 0,
    "gitlens.gitExplorer.files.layout": "tree",
    "editor.wordWrap": "on",
    "cmake.buildDirectory": "${workspaceRoot}/build",
    "editor.formatOnSave": true,
    "editor.formatOnType": true,
    "C_Cpp.clang_format_style": "file",
    "C_Cpp.clang_format_fallbackStyle": "Google",
    "C_Cpp.intelliSenseCacheSize": 0
}
"""
print("=> Load default settings...")
print(json_string0)
store0 = json.loads(json_string0)

# Load user settings
home = os.getenv("HOME")
filename1 = home + "/.config/Code/User/settings.json"  # default on linux
f1 = open(filename1, 'r')
if not f1:
    print(f"Fail to open file: {filename1}")
    sys.exit(1)
store1 = json.load(f1)
f1.close()

# Merge two setting files
print(f"Updating your settings file: {filename1}")
store1.update(store0)
# json_string = json.dumps(store1, indent=4)
f2 = open(filename1, 'w')
if not f2:
    print(f"Fail to open file: {filename1}")
    sys.exit(1)
json.dump(store1, f2, indent=4)
f2.close()
# print(json_string)

print("Done!")
