#!/bin/bash

local USER_NAME;
local REPO_NAME;

while [[ -z "$USER_NAME" ]]; do
    read -r -p $"Enter Username: " USER_NAME;
done

while [[ -z "$REPO_NAME" ]]; do
    read -r -p $"Enter Repo Name: " REPO_NAME;
done

echo "# $REPO_NAME\n" > README.md;

git init;
git add README.md;
git commit -m "initial commit";

local API_URL="https://api.github.com/user/repos";
local DATA="{'name': '${REPO_NAME}', 'private': false}";
curl -u "${USER_NAME}" "${API_URL}" -d "${DATA}";

local HEADER="accept: application/vnd.github.v3+json";
local REPO_URL="https://api.github.com/repos/$USER_NAME/$REPO_NAME";
local GIT_URL=$(curl -H "$HEADER" "$REPO_URL" | jq -r '.[].clone_url');

git branch -M main;
git remote add origin $GIT_URL;
git push -u origin main;
