#!/bin/bash

# Zip compress all content of specified directory.
#
# Usage: sh zip-it.sh docs documents/
# Permission: chmod u+x zip-it.sh
#
# Author: Mitul Vaghamshi
# Last Modified: Nov 14, 2024
#
if [ -z "$1" ]; then
    printf "Error: Output file name required!\n\n";
    printf "\tUsage: sh zip-it.sh output-file input-dir\n\n";
elif [ -z "$2" ]; then
    printf "Error: Specify input directory required!\n\n";
    printf "\tUsage: sh zip-it.sh output-file input-dir\n\n";
else
    echo "Compressing...";
    zip "$1.zip" -x ".DS_Store" "**/.DS_Store" -q -r -9 "$2/";
    realpath "$1.zip";
fi
