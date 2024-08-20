#!/bin/sh

trap "" SIGINT

echo "This program will sleep for 10 seconds "
echo "and cannot be killed with control-c."

sleep 10
