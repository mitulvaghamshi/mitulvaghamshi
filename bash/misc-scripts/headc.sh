#!/bin/sh

FILENAME=$1; COUNT=$2
SCRIPT=$(mktemp -t "head_c.XXXX")

cat > "$SCRIPT" << EOF
BEGIN { FS=""; mystr = ""; }
{ mystr = mystr "\n" \$0; }
END { print substr(mystr, 2, $COUNT); }
EOF

awk -f "$SCRIPT" "$FILENAME"
rm "$SCRIPT"

