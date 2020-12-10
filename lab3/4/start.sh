#!/bin/bash

sh cycle.sh&pid0=$!
sh cycle.sh&pid1=$!
sh cycle.sh&pid2=$!

renice +10 -p $pid0

at now + 1 minute <<< "kill ${pid0} ; kill ${pid1} ; kill ${pid2}"