#!/bin/bash

if [[ ! -d "$1" ]]; then exit 1; fi
FILES=$(find "$1" -type f -iname "*.m4a" -print);

echo "${FILES[@]}" | while read item; do
    TMP=$(echo "${item}" | sed -e 's/ \[.*\]//');
    mv "${item}" "${TMP}";
done

