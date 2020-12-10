#!/bin/bash

path="/home/user/lab3"
dates=$(date '+%F_%T')

mkdir $path/test && { echo "catalog test was created successfully" > $path/report ; touch $path/test/$dates ; }
ping www.net_nikogo.ru || echo "${dates} ping error" >> $path/report