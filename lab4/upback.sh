#!/bin/bash

if [[ ! -d ~/restore ]];
then
	mkdir ~/restore
fi

lastBackup=$(ls ~ | grep "Backup-" | sort -n | tail -1)

if [[ -d ~/$lastBackup ]];
then
	BackupLs=$(ls ~/$lastBackup)
	for line in $BackupLs;
	do
		reg='[0-9]{4}-[0-9]{2}-[0-9]{2}'
		if [[ ! $line =~ $reg ]];
		then
			cp ~/$lastBackup/$line ~/restore/$line
		fi
	done
fi

