#!/bin/bash

ans=1 
type="+"

sigterm() 
{
	exit 0
}

usr_1() 
{
	type="+"
}

usr_2() 
{
	type="*"
}

trap 'sigterm' SIGTERM
trap 'usr_1' USR1
trap 'usr_2' USR2

while true; 
do
	case "$type" in
		"+")
			let ans=$ans+2
		;;
		"*")
			let ans=$ans*2
		;;
	esac
		echo $ans
		sleep 2
done
