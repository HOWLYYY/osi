#!/bin/bash

Parentpid=0
ASUM=0
COUNT=0
Average=0

echo -e "$(<4.out)\n" | sed "s/[^0-9.]\+/ /g" | sed "s/^ //g" |
while read str; 
do
	pid=$(awk '{print $1}' <<< $str)
	ppid=$(awk '{print $2}' <<< $str)
	ART=$(awk '{print $3}' <<< $str)
	if [[ $ppid == $Parentpid ]]; then
		ASUM=$(echo "$ASUM+$ART" | bc | awk '{printf "%f", $0}')
		COUNT=$(($COUNT+1))
	else
		Average=$(echo "scale = 5; $ASUM/$COUNT" | bc | awk '{printf "%f", $0}')
		echo "Average_Children_Running_Time_of_ParentID="$Parentpid" is "$Average
		ASUM=$ART
		COUNT=1
		Parentpid=$ppid
	fi
	if [[ -n  $pid ]]; then
		echo "ProcessID="$pid" : Parent_ProcessID="$ppid" : Average_Running_Time="$ART
	fi
done > 5.out