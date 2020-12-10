#!/bin/bash

ans=1 #Default value
type="+" #Default value

TERM() 
{
	echo "script is down"
	exit 0
}

SIG1() 
{
	type="+"
}

SIG2() 
{
	type="*"
}

trap 'TERM' SIGTERM
trap 'SIG1' USR1
trap 'SIG2' USR2

while true; 
do
	case "$type" in
		"+")
			ans=$(echo "${ans} + 2" | bc)
		;;
		"*")
			ans=$(echo "${ans} * 2" | bc)
		;;
	esac
		sleep 2
		echo $ans
done