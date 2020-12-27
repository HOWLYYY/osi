#!/bin/bash

timenow=$(date '+%d.%m.%y_%H:%M')

mkdir ~/test 2>/dev/null && echo "catalog test was created successfully" > ~/report && \
touch $timenow || ping -c 2 www.net_nikogo.ru 2>/dev/null || \ 
echo "${timenow} not reachable" >> ~report
