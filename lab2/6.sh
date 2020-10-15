#$/bin/bash

echo "From /proc/:"
grep "VmRSS" /proc/[0-9]*/status | tr '/' ' ' | sort -nk 4 | tail -1 | awk '{print $2 " " $4}'
echo "From top:"
top -b -n 1 | tail -n +8 | awk '{print $1 " " $6}' | sort -nrk 2 | head -1