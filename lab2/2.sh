#$/bin/bash

ps -Ao pid,command | grep -h "[0-9] /sbin/" | awk '{print $1}' > task2_result