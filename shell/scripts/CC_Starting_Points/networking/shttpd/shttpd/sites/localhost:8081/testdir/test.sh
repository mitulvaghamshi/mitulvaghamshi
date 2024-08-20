#!/bin/sh

printf "Content-Type: text/html\r\n"
printf "X-Test: test\r\n"
printf "\r\n"

echo "PATH_INFO: $PATH_INFO"

cat "$PATH_TRANSLATED"

