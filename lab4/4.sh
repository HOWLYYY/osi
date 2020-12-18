#!/bin/bash

LBackupDate=$(ls ~ | grep -E "^Backup-" | sort -n | tail -1 | sed 's/^Backup-//')
LBackup="$HOME/Backup-${LBackupDate}"

if [[ -z "$LBackupDate" ]];
then
	echo "Ошибка: Нет ББ"
	exit 404
fi

if [[ ! -d ~/restore ]];
then
	mkdir ~/restore
else
	rm -r ~/restore
	mkdir ~/restore
fi

for obj in $(ls $LBackup | grep -Ev "\.[0-9]{4}-[0-9]{2}-[0-9]{2}$");
do
	cp "${LBackup}/${obj}" "$HOME/restore/${obj}"
done