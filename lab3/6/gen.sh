#!/bin/bash


while true; 
do
	read str
	case "$str" in
		"TERM")
			kill -SIGTERM $1
			exit 0
		;;
		"+")
			kill -USR1 $1
		;;
		"*")
			kill -USR2 $1
		;;
		*)
			continue
		;;
	esac
done