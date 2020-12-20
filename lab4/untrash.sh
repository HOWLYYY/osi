#!/bin/bash
IFS=$'\n'

if [[ $# != 1 ]]; then
    echo "Only 1 argument expected"
    exit 1;
fi

FILENAME="$1"

TRASH_DIR_PATH="$HOME/.trash"
TRASH_LOG_PATH="$HOME/.trash.log"

LOG_DATA=$(cat "$TRASH_LOG_PATH")


for line in $LOG_DATA
do
    LINE_FILE_NAME=$(echo "$line" | sed 's/[[:space:]][^[:space:]]*$//')
    LNNAME=$(echo "$line" | sed 's@.*[[:space:]]@@')    
    
    if [[ "$LINE_FILE_NAME" == *"$FILENAME"* ]]; then
        echo "Recover file '$LINE_FILE_NAME' [Y/n]?"
        read answer </dev/tty
        
        if [[ $answer == 'Y' ]]; then
             while [[ -e "$LINE_FILE_NAME" ]]
             do
                 echo "Can't recover file $LINE_FILE_NAME"
                 echo "Pls enter new file name"
                 read new_name </dev/tty
                 LINE_FILE_NAME="$new_name"
             done

	     ln "$TRASH_DIR_PATH/$LNNAME" "$LINE_FILE_NAME"
             rm "$TRASH_DIR_PATH/$LNNAME"
             sed -i "/$LNNAME/d" "$TRASH_LOG_PATH"
             echo "SUCCESS"
             exit 0
        fi
        echo "$answer"
    fi    
done
