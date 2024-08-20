#!/bin/bash

# Clone all public GitHub repositories of a given username
# into currrent folder.
#
# Usage: sh clone-repos.sh johndoe
# Permission: chmod u+x clone-repos.sh
#
# Author: Mitul Vaghamshi
# Last Modified: Nov 14, 2024
#
# Todo: - Clone only first N repos.
#       - Destination path.
#       - Option to clone gists.
#       - Quite mode flag.
#       - Dry run (print only).
#
if [ -z "$1" ]; then
    printf "Error: GitHub username required!\n\n";
    printf "\tUsage: sh clone-repos.sh username\n\n";
else
    curl -fs "https://api.github.com/users/$1/repos?per_page=100" | sed -nE '/clone_url/s/(clone_url":)|[", ]//gp' | while read url; do
        git clone "$url";
    done
fi
