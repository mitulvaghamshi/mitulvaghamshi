#!/bin/bash

NAME_LIST="";
PUB_LIST="";

function consent {
    echo "This will update 'pubspec.yaml' and 'main.dart' to include fonts.";
    read -t 5 -n 1 -p "Do you want to continue: (y/n)? " CONSENT;

    case "${CONSENT}" in
        "Y" | "y") check ;;
        *) exit 0 ;;
    esac
}

function check {
    visit "assets";

    cat "pubspec.yaml" | grep -sqF "fonts:"
    if [[ "$?" -ne 0 ]]; then
        echo "  fonts:\n${PUB_LIST}" >> pubspec.yaml;
    fi

    cat "lib/main.dart" | grep -sqF "const fonts"
    if [[ "$?" -ne 0 ]]; then
        echo "const fonts = [${NAME_LIST}];" >> ./lib/main.dart;
    fi
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

consent;
