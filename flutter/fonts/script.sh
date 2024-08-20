#!/bin/bash

NAME_LIST="";
PUB_LIST="";

function check {
    cat lib/main.dart | grep -sqF "const fonts"
    if [[ "$?" -eq 0 ]]; then
        echo "main.dart may alrady contains the font entry, exiting...";
        exit 0;
    fi

    cat pubspec.yaml | grep -sqF "fonts:"
    if [[ "$?" -eq 0 ]]; then
        echo "pubspec.yaml may alrady contains the fonts entry, exiting...";
        exit 0;
    fi
}

function consent {
    echo "This will update 'pubspec.yaml' and 'main.dart' to include fonts from 'assets' folder.";
    read -t 5 -n 1 -p "Do you want to continue: (y/n)? " CONSENT;

    case "${CONSENT}" in
        "Y" | "y")
        visit "assets";
        echo "  fonts:\n${PUB_LIST}" >> pubspec.yaml;
        echo "const fonts=[${NAME_LIST}];" >> ./lib/main.dart;
        ;;
        *) exit 0;
        ;;
    esac
}

function visit {
    local item;
    for item in "$1"/*; do
        if [[ -d "$item" ]]; then
            visit "$item";
        elif [[ -f "$item" ]]; then
            process "$item";
        fi
    done
}

function process {
    BNAME=$(basename "$1");
    NAME="${BNAME%.*}";
    NAME_LIST="${NAME_LIST}'${NAME}',";
    PUB_LIST="${PUB_LIST}    - family: ${NAME}\n      fonts:\n        - asset: $1\n";
}

check; # Exit if files were already updated.
consent; # Ask if user wants to proceed, exit otherwise,
