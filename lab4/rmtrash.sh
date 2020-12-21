#!/bin/bash

FILENAME="$1"
FILE_PATH="$PWD/$1"


if [[ $# != 1 ]]; then
    echo "Only 1 argument expected"
    exit 0
fi

if [[ ! -f $FILE_PATH ]]; then
    echo "File not found"
    exit 0
fi

TRASH_DIR_PATH="$HOME/.trash"
TRASH_LOG_PATH="$HOME/.trash.log"

if [[ ! -e $TRASH_DIR_PATH ]]; then
    mkdir "$TRASH_DIR_PATH"
fi

if [[ ! -f $TRASH_LOG_PATH ]]; then
    touch "$TRASH_LOG_PATH"
fi

timestamp=$(date +%s)
LNNAME="$timestamp"

cnt=1
while(true)
do
if [[ ! -f "$TRASH_DIR_PATH/$LNNAME"_"$cnt" ]]; then
    LNNAME="$LNNAME"_"$cnt"
    break
fi
cnt=$((cnt+1))
done

ln "$FILE_PATH" "$TRASH_DIR_PATH/$LNNAME"
echo "$FILE_PATH $LNNAME" >> $TRASH_LOG_PATH

rm "$FILE_PATH"
