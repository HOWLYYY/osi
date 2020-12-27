#!bin/bash

max_mem=0
it_mem=0
found_pid=0
for pid in $(ls /proc/ | grep -E "^[0-9]+$");
do
	it_mem=$( cat "/proc/$pid/statm" | awk '{ print $2 }')
	if [[ "$it_mem" -gt "$max_mem" ]]
	then
		found_pid="$pid"
		max_mem="$it_mem"
	fi
done 2>/dev/null

echo "statm" Max $max_mem bytes, pid $found_pid"
top -o %MEM -b | head -n 8 | tail -n 1 | awk '{printf "top: Max %s bytes, pid %s\n", $1, $6}'
