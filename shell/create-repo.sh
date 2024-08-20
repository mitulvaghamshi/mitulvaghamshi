#!/bin/bash
while [ -z "$REPO_NAME" ]; do read -r -p $"Enter Repo Name:" REPO_NAME; done;
printf "# $REPO_NAME\n" >> README.md;
git init; git add README.md; git commit -m "initial commit";
curl -u "$1" "https://api.github.com/user/repos" -d "{"name": '$REPO_NAME', "private": false}";
GIT_URL=$(curl -H "Accept: application/vnd.github.v3+json" "https://api.github.com/repos/$1/$REPO_NAME" | jq -r ".clone_url");
git branch -M main;
git remote add origin $GIT_URL;
git push -u origin main;
