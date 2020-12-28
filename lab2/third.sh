#!bin/bash

ps aux | sort -k9 | tail -n 2 | head -n 1 | awk '{print $2}' >lab3_res.txt
