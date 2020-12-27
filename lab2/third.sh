#!bin/bash

ps -eo pid,ppid,lstart --sort=start_time | awk '{ if ($2 != "$$") print $1 }' | tail -n 1 > lab3_res.txt
