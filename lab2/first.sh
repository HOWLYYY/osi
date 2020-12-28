!#/bin/bash

ps -U $USER | wc -l >res
ps -U $USER | tail -n +2 | awk '{ print $1 ":" $4 }' >>lab1_res.txt
