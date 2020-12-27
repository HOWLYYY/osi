#!bin/bash

declare -A bytes_at_finish

for pid in $(ps aux | tail -n+2 | awk '{print $2}' );
do
	bytes=$(cat "/proc/$pid/io" | grep ead_bytes | awk '{print $2}' )
	bytes_at_finish[$pid]="$bytes"
done 2> /dev/null

for pid in ${!bytes_at_finish[@]};
do
	finish=${bytes_at_finish[$pid]}
	start=${bytes_at_start[$pid]}
	if [[ "$start" == "" ]]
	then 
		start=0
	fi
	cmd=$(cat "/proc/$pid/cmdline" 2>/dev/null | tr '\000' ' ')
	bytes=$(echo "$finish-$start" | bc -l)
	echo "$bytes $pid $cmd"
done | sort -n | tail -n 3 | awk '{pintf "%s:%s:%s\n", $2, $3, $1}'
