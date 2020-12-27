#!bin/bash

Result="$(ps axo pid,ppid,user,comm | awk '{ if($3 == "user" && $2 != "$$") printf "%s:%s\n", $1, $$

echo "$Result" | wc -l > lab1_res.txt
echo "$Result" >> lab1_res.txt
