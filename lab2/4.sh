#$/bin/bash

for pid in $(ps -Ao pid | tail -n +2)
do
	ppid=$(grep -Ehsi "ppid:\s+.+" /proc/$pid/status | grep -o "[0-9]\+")
	runtm=$(grep -Ehsi "se\.sum_exec_runtime.+:\s+.+" /proc/$pid/sched | awk '{print $3}')
	swtch=$(grep -Ehsi "nr_switches.+:\s+.+" /proc/$pid/sched | awk '{print $3}')
	if [ -z $ppid ]; then
		ppid=0
	fi
	if [ -z $runtm ] || [ -z $swtch ]; then
		art=0
	else
		art=$(echo "scale=2; $runtm/$swtch" | bc)
	fi
	echo "$pid $ppid $art"
done | sort -nk 2 | awk '{print "ProcessID="$1 " : " "Parent_ProcessID="$2 " : " "Average_Running_Time="$3}' > task4_result