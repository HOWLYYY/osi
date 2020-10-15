#!/bin/bash


ps aux | awk '{if ($6 != 0) print $2" "$6" "$11}' | sort -nk1 | tail -n +2 | head -n -6 > task2_1.temp
sleep 1m
ps aux | awk '{if ($6 != 0) print $2" "$6" "$11}' | sort -nk1 | tail -n +2 | head -n -6 > task2_2.temp

cat task2_1.temp |
while read line; do
	pid=$(awk '{print $1}' <<< $line)
	mem0=$(awk '{print $2}' <<< $line)
	cmd=$(awk '{print $3}' <<< $line)
	mem1=$(cat task2_2.temp | awk -v id="$pid" '{if ($1 == id) print $2}')
	memdif=$(echo "$mem1-$mem0" | bc)
	echo $pid" "$cmd" "$memdif
done | sort -nrk3 | head -3

rm -f *.temp