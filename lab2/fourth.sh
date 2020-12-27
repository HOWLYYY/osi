#!bin/bash

IFS=$'\n'

function allPrrocess
{
for line in $(ps aux)
do 
	_PID=$(echo $line | awk '{ print $2 }')
	if [ -d "/proc/$_PID/" ] ;
	then
		_PPID=$(cat "/proc/$_PID/" | grep "PPid" | awk '{ print $2 }' )
		sum_exec_runtime=$(cat "/proc/$_PID/sched" | grep "sum_exec_runtime" | awk '{ print $3 }')
		nr_switches=$(cat "/proc/$_PID/sched" | grep "nr_switches" | awk '{ print $3 }')
		ART=$(echo $sum_exec_runtime/$nr_switches | bc -l)
		echo "$_PPID $_PID $ART"
	fi
done
}

allProcess | sort -n | awk '{ printf "PocessID=%s : Parent_ProcessID=%s : Average_Running_Time=%s" }'
