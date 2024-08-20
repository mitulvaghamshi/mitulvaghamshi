#!/bin/bash

# Usage:         sh clone-repos.sh johndoe
# Permission:    chmod u+x clone-repos.sh
# Author:        Mitul Vaghamshi
# Last Modified: Wed 12 Mar 2025 23:30:22 EDT
#
# Todo:
# - Clone only first N repos
# - Option to specify output
# - Option to clone gists
# - Option to zip'em all
#
# Clone all public GitHub repos of a given user(name) into currrent folder
if [ -z "$1" ]; then
    echo "Please specify username (i.e. johndoe)."
else
    echo "Please wait..."
    mkdir "$1" && cd "$_"
    curl -fs "https://api.github.com/users/$1/repos?per_page=100" | \
    sed -nE '/clone_url/s/(clone_url":)|[", ]//gp' | \
    while read url; do git clone --bare --quiet "$url"; done
fi
