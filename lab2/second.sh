#!bin/bash

ps ax | awk '{ if($5 ~ "^/sbin/.*") print $1 }' > lab2_res.txt
