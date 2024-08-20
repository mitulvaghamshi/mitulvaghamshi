#!/bin/bash

set -euo pipefail

USER_NAME=$(git config --get user.name)
read -rp "Enter New Repository Name: " REPO_NAME
mkdir -p "$HOME/$REPO_NAME" && cd "$_" || exit 1

echo "# $REPO_NAME\n" > README.md

git init
git add README.md
git commit -m "initial commit"

API_URL="https://api.github.com/user/repos"
DATA="{'name': '${REPO_NAME}', 'private': false}"
curl -u "${USER_NAME}" "${API_URL}" -d "${DATA}"

HEADER="accept:application/vnd.github.v3+json"
REPO_URL="https://api.github.com/repos/$USER_NAME/$REPO_NAME"
GIT_URL=$(curl -H "$HEADER" "$REPO_URL" | jq -r '.[].clone_url')

git branch -M main
git remote add origin "$GIT_URL"
git push -u origin main
