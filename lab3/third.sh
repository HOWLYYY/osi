#!/bin/bash
 
tasks=$(crontab -l)
tasks+=$'\n'
tasks+="*/5 * * * 3 /home/user/lab3/first.sh"
echo "$tasks" | crontab
