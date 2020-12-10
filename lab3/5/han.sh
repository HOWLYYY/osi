#!/bin/bash

value=1 #Default value
type="+" #Default value
tail -f buffer |
while true; do
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
		    	echo "exit"
	 		killall tail
			exit 0
		;;
		[0-9]*)
			case $type in
				"+")
					value=$(echo "${value} + ${str}" | bc)
					echo $value
				;;
				"*")
					value=$(echo "${value} * ${str}" | bc)
					echo $value
				;;
			esac
		;;
		*)
			echo "ERROR"
			killall tail
			exit 1
		;;

	esac
done