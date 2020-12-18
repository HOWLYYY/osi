#!/bin/bash

LBackupDate=$(ls ~ | grep -E "^Backup-" | sort -n | tail -1 | sed "s/Backup-//")
LBackup="$HOME/Backup-${LBackupDate}"
Today=$(date +"%Y-%m-%d")
nowTimes=$(date -d "$Today" +"%s")
LBackupTimes=$(date -d "$LBackupDate" +"%s")
Totaltime=$(echo "(${nowTimes} - ${LBackupTimes}) / 60 / 60 / 24" | bc)
rep=~/.backup-report



if (( $Totaltime > 7 )) || [[ -z "$LBackupDate" ]];
then
	mkdir "$HOME/Backup-${Today}"
	for obj in $(ls ~/source);
do
		cp "$HOME/source/$obj" "$HOME/Backup-$Today"
	done
	flist=$(ls ~/source | sed "s/^/\t/")
	echo -e "ББ (${Today}) Был создан:\n${flist}" >> $rep
else
	changes=""
	for obj in $(ls ~/source);
do
		if [[ -f "$LBackup/$obj" ]];
then
			sourceSize=$(wc -c "$HOME/source/${obj}" | awk '{print $1}')
			BackupSize=$(wc -c "${LBackup}/${obj}" | awk '{print $1}')
			TotalSize=$(echo "${sourceSize} - ${BackupSize}" | bc)

			if (( $TotalSize != 0 ));
then
				mv "$LBackup/$obj" "$LBackup/$obj.$Today"
				cp "$HOME/source/$obj" $LBackup
				changes="${changes}\n\tFile $obj updated. Previous version: $obj.$Today."
			fi
		else
			cp "$HOME/source/$obj" $LBackup
			changes="${changes}\n\tФайл $obj Скопирован."
		fi
	done
	changes=$(echo $changes | sed 's/^\\n//')
	if [[ ! -z "$changes" ]];
then
	echo -e "ББ (${LBackupDate}) Обновлён\n${changes}" >> $rep
	fi
fi