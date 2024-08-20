#!/bin/sh

## ARGUMENTS
# $0 - The filename of the current script.
# $n - The Nth argument passed to script was invoked or function was called.
# $# - The number of argument passed to script or function.
# $@ - All arguments passed to script or function.
# $* - All arguments passed to script or function.
# $? - The exit status of the last command executed.
# $$ - The process ID of the current shell. For shell scripts, this is the process ID under which they are executing.
# $! - The process number of the last background command.

## ARRAYS
NAMES=( Alex John Ann Marry ) # Define and init
NAMES[2]="Anna" # Update
NAMES[${#NAMES[@]}]="Dave" # Add ar the end
echo "${NAMES[@]} : ${#NAMES[@]}" # Print elements and len

## OPERATORS

VALUE1=10
VALUE2=$((100 * ${A} + 2))

## STRINGS
# STR="This is a string value."
# ${#STR} - string len
# ${STR:2-(start pos):3-(optional len)} - substr
# expr index $STR "a" - index of "a"
# ${STR[@]/This/That} - reaplce first "This" with "That"
# ${STR[@]//This/That} - reaplce all "This" with "That"
# ${STR[@]//a} - replace "a" with empty string - delete
# ${STR[@]/#T/t} - "#" replaces if at the beggining
# ${STR[@]/%T/t} - "%" replaces if at the end only

## DECISION MAKING

# A empty string or a string consisting of spaces or
# an undefined variable name, are evaluated as false.

NAME="Alex"

if [[ "${NAME}" == "Alex" ]]; then
    echo "Hi, ${NAME}.";
elif [[ "${NAME}" == "Anna" ]]; then
    echo "Hey, ${NAME}.";
else
    echo "Hello, Guest.";
fi

### LOGICAL

# if [[ $VAR_A[0] -eq 1 && ($VAR_B = "bee" || $VAR_T = "tee") ]] ; then
# fi

### SWITCH-CASE

CHOICE=5
case "${CHOICE}" in
    1 | 2 | 3 )
        echo "Small."
    ;;
    4 | 5 | 6 )
        echo "Medium."
    ;;
    7 | 8 | 9 )
        echo "big."
    ;;
esac

CHOICE=2
case $CHOICE in
    1) echo "You selected bash";;
    2) echo "You selected zsh";;
    3) echo "You selected sh";;
    4) echo "You selected c";;
    5) exit
esac

### Numeric comparisons

# Comparison - Evaluated to true when
# $a -lt $b  - $a <  $b
# $a -gt $b  - $a >  $b
# $a -le $b  - $a <= $b
# $a -ge $b  - $a >= $b
# $a -eq $b  - $a == $b
# $a -ne $b  - $a != $b

### String comparisons

# Comparison   - Evaluated to true when
# "$a" = "$b"  - $a is the same as $b
# "$a" == "$b" - $a is the same as $b
# "$a" != "$b" - $a is different from $b
# -z "$a"      - $a is empty
# -e "${filename}" - if file exist
# -f "${filename}" - if file exist
# -r "${filename}" - if you have read permission
# -d "${dirname}"  - if directory exist

## LOOP

### For loop

ITEMS=( 1 2 3 )
for item in "${ITEMS[@]}"; do
    echo "Item: $item";
done

for name in Alex Anna Marry; do
    echo "$name";
done

for file in $( ls ); do
    echo "${file}";
done

### While loop

COUNT=4
while [ $COUNT -gt 0 ]; do
  echo "Value: $COUNT";
  COUNT=$(($COUNT - 1))
done

### Until loop

until [ $COUNT -gt 5 ]; do
  echo "Value: $COUNT";
  COUNT=$(($COUNT + 1))
done

function func {
    for ARG in $*; do
        echo $ARG
    done

    for ARG in "$*"; do
        echo $ARG
    done

    for ARG in $@; do
        echo $ARG
    done

    for ARG in "$@"; do
        echo $ARG
    done
}
func One Two Three

## TRAP

# SIGINT(2): user sends an interrupt signal (Ctrl + C)
# SIGQUIT(3): user sends a quit signal (Ctrl + D)
# SIGFPE(8): attempted an illegal mathematical operation
# SIGKILL(9): signal to kill the process immediately
# SIGTERM(15): generic signal used to cause process termination (Ctrl + Z)

# Trap can be used for cleanup process
# i.e. - trap "rm -f folder; exit" 2

# trap "echo '\nlol'" SIGINT SIGTERM
# while true; do
#     echo ">\c";
#     sleep 1;
# done

## PIPELINES

# By default pipelines redirects only the standard output,
# if you want to include the standard error you need to use
# the form `|&` which is a short hand for `2>&1 |`.

# FILES=`ls`
# echo ${FILES}

# FILE_COUNT=$(expr `ls | wc -l`)
# echo "# of files: ${FILE_COUNT}"

# TMP_FILE=$(mktemp File.XXXX)
# expr `realpath $TMP_FILE`

# OUTPUT
# diff <(sort file1) <(sort file2)

# INPUT
# echo "$(/bin/date)" | tee "exec.log"
# Command not working:
# echo "Hello, World!" | tee >(tr '[:upper:]' '[:lower:]' > "exec.log")

# Convert to webp in bulk
# for file in "dir/*"; do cwebp "${file}" -o "${file%.*}.webp"; done
