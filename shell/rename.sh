#!/bin/bash

function visit {
    local item;
    for item in "$1"/*; do
        if [ -d "${item}" ]; then visit "${item}";
        elif [ -f "${item}" ]; then action "${item}"; fi
    done
}

function action {
    case "$1" in *.m4a)
        NAME=`echo "$1" | sed -e 's/ \[.*\]//'`;
        mv "$1" "${NAME}";
        ;;
    esac
}

visit "$1";

# find "$1" -type f -iname "*.m4a" -print | while read file; do TMP=$(echo $file | tr -d 'img-'); mv $file $TMP; done
