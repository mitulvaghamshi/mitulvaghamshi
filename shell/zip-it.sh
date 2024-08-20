#!/bin/bash
FILE_OUT="$1.zip"; DIR_IN="$2";
if [[ "$#" != 2 ] || [ -f "$FILE_OUT" ] || [ ! -d "$DIR_IN" ]]; then exit 1; fi
echo "Please wait...";
zip "$FILE_OUT" -x ".DS_Store" -x "**/.DS_Store" -x "._*" -x "**/._*" -q -r -9 "$DIR_IN"
if [ -f "$FILE_OUT" ]; then realpath "$FILE_OUT"; fi
