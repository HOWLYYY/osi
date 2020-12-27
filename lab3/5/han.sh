#!/bin/bash

value=1 
type="+"
tail -f buffer | while true; 
do
	read str
	case $str in
		"+")
			type="$str"
			echo "sum"
		;;
		"*")
			type="$str"
			echo "multiplicate"
		;;
		"QUIT")
	 		killall tail
			exit 0
		;;
		[0-9]*)
			if [[ $type == '+' ]]
			then
				echo $(($value + $line))
			else
				echo $(($value * $line))
			fi
		;;
		*)
			echo "ERROR"
			killall tail
			exit 1
		;;

	esac
done
