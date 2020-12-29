#!/bin/bash

datenow=$(date +'%Y/%m/%d')
lastback=$(ls ~ | grep "Backup-" | sort -n | tail -1 | cut -d "-" -f 2)
datenowsec=$(date -d "$datenow" +%s)
lastbacksec=$(date -d "$lastback" +%s)
let diff=($datenowsec-$lastbacksec)/60/60/24
AddFilesToBackup(){
	Source=$(ls ~/source)
	for file in $Source;
	do
		if [[ -f ~/Backup-$lastback/$file ]];
		then
			sizeSource=$(stat -c%s ~/source/$file)
			sizeBackup=$(stat -c%s ~/Backup-$lastback/$file)
			if [[ ! sizeSource -eq sizeBackup ]];
			then
				ln ~/Backup-$lastback/$file ~/Backup-$lastback/$file-$datenow
				rm ~/Backup-$lastback/$file
				cp ~/source/$file ~/Backup-$lastback/$file
				echo "$file was renamed to $file-$datenow" >>~/backup-report
			fi
		else
			cp ~/source/$file ~/Backup-$lastback/$file
			echo "$file was added to Backup" >>~/backup-report
		fi
	done
}
if [[ $diff -gt 7 ]];
then
	mkdir "home/user/Backup-$datenow"
	cp -a ~/source/. ~/Backup-$datenow
	echo "Backup-$datenow was created" >>~/backup-report
	ls ~/source >>~/backup-report
else
	AddFilesToBackup
fi
