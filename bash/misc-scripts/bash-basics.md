# Bash Basics

## ARGUMENTS

- `$0` - First arg (script name)
- `$n` - Nth arg (passed in)
- `$#` - Total args
- `$@` - All args passed (space separated when quoted)
- `$*` - All args passed (single string when quoted)
- `$_` - Last arg of previous command
- `$$` - PID of the current shell (PPID for scripts)
- `$!` - Process number of last background command
- `$?` - Exit status of last command

## ARRAYS

```sh
NAMES=( Alex John Ann Marry ) # Define and Initialize
NAMES[2]="Anna" # Update element
NAMES[${#NAMES[@]}]="Dave" # Add element at the end
echo "${NAMES[@]} : ${#NAMES[@]}" # Print elements and length
```

## OPERATORS

```sh
VALUE=10
echo $((100 * VALUE + 2))
```

## STRINGS

```sh
STR="This is a string value"

echo ${#STR}              # String length
echo ${STR:2:3}           # Substring (str, pos, len)
echo expr index $STR "a"  # Index of "a"
echo ${STR[@]/This/That}  # reaplce first "This" with "That"
echo ${STR[@]//This/That} # reaplce all "This" with "That"
echo ${STR[@]//a}         # replace "a" with empty string - delete
echo ${STR[@]/#T/t}       # "#" replaces if at the beggining
echo ${STR[@]/%T/t}       # "%" replaces if at the end only
```

## DECISION MAKING

A empty string or spaces or an undefined variable name, are `false`.

```sh
NAME="Alex"
if [[ "${NAME}" == "Alex" ]]; then echo "Hi, ${NAME}.";
elif [[ "${NAME}" == "Anna" ]]; then echo "Hey, ${NAME}.";
else echo "Hello, Guest."; fi
```

## LOGICAL

```sh
if [[ $VAR_A[0] -eq 1 && ($VAR_B = "bee" || $VAR_T = "tee") ]]; then ; fi
```

## SWITCH-CASE

```sh
CHOICE=5
case "${CHOICE}" in
    1 | 2 | 3 ) echo "Small." ;;
    4 | 5 | 6 ) echo "Medium." ;;
    7 | 8 | 9 ) echo "Big." ;;
esac

CHOICE=2
case $CHOICE in
    1) echo "bash";;
    2) echo "zsh";;
    3) echo "sh";;
    4) echo "c";;
    5) exit 0;;
esac
```

## Numeric comparisons

Comparisons evaluated to `true` when:

```sh
if [ "$a" -lt "$b" ]; # $a <  $b
if [ "$a" -gt "$b" ]; # $a >  $b
if [ "$a" -le "$b" ]; # $a <= $b
if [ "$a" -ge "$b" ]; # $a >= $b
if [ "$a" -eq "$b" ]; # $a == $b
if [ "$a" -ne "$b" ]; # $a != $b
```

## String comparisons

Comparison evaluated to `true` when:

```sh
if [ "$a" = "$b"      ]; # $a is the same as $b
if [ "$a" == "$b"     ]; # $a is the same as $b
if [ "$a" != "$b"     ]; # $a is different from $b
if [ -z "$a"          ]; # $a is empty
if [ ! -z "$a"        ]; # $a is not empty
if [ -e "${filename}" ]; # item exists
if [ -f "${filename}" ]; # refer to file only, no symlink or dir
if [ -r "${filename}" ]; # if you have read permission
if [ -d "${dirname}"  ]; # if directory exist
```

## For LOOP

```sh
ITEMS=( 1 2 3 )
for item in "${ITEMS[@]}"; do echo "$item"; done
for name in Alex Anna Marry; do echo "$name"; done
for file in $(ls); do echo "${file}"; done
```

## While LOOP

```sh
COUNT=5
while [ $COUNT -gt 0 ]; do COUNT=$((COUNT - 1)); done
```

## Until LOOP

```sh
COUNT=0
until [ $COUNT -gt 5 ]; do COUNT=$((COUNT + 1)); done
```

## FUNCTIONS

```sh
function func {
    for ARG in $*; do print $ARG; done; echo
    for ARG in "$*"; do print $ARG; done; echo
    for ARG in $@; do print $ARG; done; echo
    for ARG in "$@"; do print $ARG; done; echo
}

func "One" "Two" "Three" # Call
```

## TRAP

- `SIGINT(2)`   - User sends an interrupt signal (Ctrl + C)
- `SIGQUIT(3)`  - User sends a quit signal (Ctrl + D)
- `SIGFPE(8)`   - Attempted an illegal mathematical operation
- `SIGKILL(9)`  - Signal to kill the process immediately
- `SIGTERM(15)` - Generic signal used to cause process termination (Ctrl + Z)

Trap can be used for cleanup process, i.e.: `trap "rm -rf folder; exit" 2`

```sh
trap "echo '\nlol'" SIGINT SIGTERM
while true; do echo ">\c"; sleep 1; done
```

## PIPELINES

By default, pipelines redirect only `stdout`, to include `stderr`, use `|&`, which is a short for `2>&1 |`.

```sh
FILE_LIST=$(ls)
FILE_COUNT=$(ls|wc -l)

realpath "$(mktemp File.XXXXX)"
diff <(sort file1) <(sort file2)

date | tee "exec.log"
echo "HellO!" | tee >(tr '[:upper:]' '[:lower:]' > "exec.log")
```

## Bulk convert images to webp

```sh
for img in dir/*; do cwebp "${img}" -o "${img%.*}.webp"; done
```

## Sample

```sh
shar $(find . -type f -iname "*.sh" -print) > scripts.sh

tar -czf - file1 file2 | { if cd "/dest"; then tar -xzf - ; fi }

seq -f "test/File%g\ \[dfxdxx53\]\.m4a" 10 | xargs touch

DEFINED=$(printenv | grep -c '^VARIABLE=')

AREA=$(perl -e "print \"The value is \".($PI * ($RAD*$RAD)).\"\n\";")

echo "$STR" | perl -e "$/=undef; print substr(<STDIN>, 0, $CHARS);"

perl -pi.bak -e 's/lamb,?/orange/' < poem.txt

sed -En 's/^[ ]*"clone_url":[ ]?"(.*)",/\1/p' repos.json

grep 'Mary[[:alpha:][:digit:][:blank:]][[:alpha:][:digit:][:blank:]]*lamb' poem.txt
```
