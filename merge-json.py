#! /usr/bin/env python3
# Merge two json files
# Author: aurelien.esnard@u-bordeaux.fr

import sys
import json

### Usage
if len(sys.argv) != 3:
    print("Usage: ./merge-json.py file0.json file1.json")
    sys.exit(1)

### Load first file
filename0 = sys.argv[1]
f0 = open(filename0, 'r')
if not f0:
    print(f"Fail to load file: {filename0}")
    sys.exit(1)
store0 = json.load(f0)

### Load second file
filename1 = sys.argv[2]
f1 = open(filename1, 'r')
if not f1:
    print(f"Fail to load file: {filename1}")
    sys.exit(1)
store1 = json.load(f1)

### Merge two files on standard output
store1.update(store0)
json_string = json.dumps(store1, indent=4)
print(json_string)

