#!/bin/bash

# Usage:         sh zip-it.sh docs documents/
# Permission:    chmod u+x zip-it.sh
# Author:        Mitul Vaghamshi
# Last Modified: Wed 12 Mar 2025 23:11:49 EDT
#
# Compress all content of specified directory,
# excluding macOS .DS_Store and ._DS_Store files
if [ "$#" != 2 ]; then
    echo "Please specify missing arguments."
else
    echo "Please wait..."
    /usr/bin/zip "$1.zip" -x ".DS_Store" "**/.DS_Store" -q -r -9 "$2/"
    realpath "$1.zip"
fi
