#!/bin/bash
UNAME="$1";
if [[ "$#" -lt 1 ] || [ -z "$UNAME" ]]; then exit 1; fi
echo "Please wait...";
mkdir "$UNAME" && cd "$_";
curl -fs "https://api.github.com/users/$UNAME/repos?per_page=100" | \
sed -nE '/clone_url/s/(clone_url":)|[", ]//gp' | \
while read URL; do git clone --bare --quiet "$URL"; done
