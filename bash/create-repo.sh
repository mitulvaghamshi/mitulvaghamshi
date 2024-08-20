#!/bin/bash
# Create new repository
while [ -z "$repo" ]; do
    read -r -p $'Repository name:' repo;
done;

printf "# $repo\n" >> README.md;

git init; git add README.md; git commit -m "Initial Commit";
curl -u $1 https://api.github.com/user/repos -d '{"name": "$repo", "private": false}';
GIT_URL=$(curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/$1/"$repo" | jq -r '.clone_url');
git branch -M main;
git remote add origin $GIT_URL;
git push -u origin main;
