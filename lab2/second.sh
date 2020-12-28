#!bin/bash

ps x -A | grep -e " /sbin" | head -n -1 | awk '{print $1}' >lab2_res.txt
