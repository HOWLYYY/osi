#!bin/bash

IFS=$'\n'

last_ppid="-1"
cnt=0
sum=0
file_name="lab4_result.txt"
prev_rows=""

for line in $(cat "$file_name")
do
	ppid=$(echo $line | cut -d ":" -f 2 | cut -d "=" -f 2)
	art=$(echo $line | cut -d ":" -f 3 | cut -d "=" -f 2)
	if [ $last_ppid != $ppid ]; then
		if [ $cnt -gt 0 ]; then 
			avr=$(echo $sum/$cnt | bc -l)
			echo "$prev_rows" | awk 'NR>1{printf "\n"} {printf $0}'
			echo "Average_Sleeping_Childern_of_Parent=$last_ppid is $avr"
		fi
	cnt=0
	sum=0
	prev_rows=""
	fi
cnt=$(echo $cnt+1 | bc -l)
sum=$(echo $sum+$art | bc -l)
last_ppid="$ppid"
prev_rows+="$line"
prerv_rows+=$'\n'
done
