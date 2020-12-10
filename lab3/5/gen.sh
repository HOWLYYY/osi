#!/bin/bash

while true; do
	read str
	echo "$str" > buffer

	if [[ "$str" == "QUIT" ]]; then
		exit 0
	fi

	if [[ "$str" != "+" && "$str" != "*" && ! "$str" =~ [0-9]+ ]]; then
		exit 1
	fi
done