#!/bin/sh

POEM="$PWD/../../poem.txt"
if [ ! -f "$POEM" ]; then exit 1; fi

cat << EOF | osascript -l AppleScript
launch application "TextEdit"
tell application "TextEdit"
	open "$POEM"
end tell
EOF
