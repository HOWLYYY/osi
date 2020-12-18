#!/bin/bash

TRDIR=".trash/"
TRLOG=".trash.log"

if [[ $# > 1 ]];
then
        echo "Много Аргументов!!!!!!!"
        exit 404
fi

if [[ $# != 1 ]];
then
        echo "Мало аргументов!!!!!"
        exit 404
fi


if [[ ! -d $TRDIR ]];
then
        echo "Нет папки"
        exit 404
fi

if [[ ! -f $TRLOG ]];
then
        echo "Нет лог файла"
        exit 404
fi
if [ ! "`echo $1 | sed 's/[a-z,0-9,_,-]*//'`" == "" ];
then
	echo "Нужно вводить только имя файла! Без полного пути!"
	exit 404
fi

for i in $(grep "$1" $TRLOG | awk '{print $NF}');
do
        FN=$(grep $i $TRLOG | awk '{$NF=""; print $0}')
        FN=$(echo "$FN" | sed 's/ *$//')
        read -p "${FN} Введите: [y/n] " ans

        case "$ans" in
                "y")
		NFN=""
        TN=$i
        RDIR=$(echo "$FN" | awk 'BEGIN{FS=OFS="/"}; {$NF=""; print $0}')
        FNN=$(echo "$FN" | awk 'BEGIN{FS="/"}; {print $NF}')

        if [[ ! -d $RDIR ]];
		then
                echo "Папки в ${RDIR} не найдено. \"${FNN}\" восстановлен в домшанюю директорию."
                if [[ -f "${HOME}/${FNN}" ]];
				then
                        read -p "Файл \"~/${FNN}\" уже существует. Новое имя: " NFN
                        ln "${TRDIR}/${TN}" "${HOME}/${NFN}"
                        rm "${TRDIR}/${TN}"
                else
                        ln "${TRDIR}/${TN}" "${HOME}/${FNN}"
                        rm "${TRDIR}/${TN}"
                fi
        else
                if [[ -f "${FN}" ]];
				then
                        read -p "Файл \"${FN}\" уже существует. Новое имя:" NFN
                        ln "${TRDIR}/${TN}" "${RDIR}/${NFN}"
                        rm "${TRDIR}/${TN}"
                else
                        ln "${TRDIR}/${TN}" "${FN}"
                        rm "${TRDIR}/${TN}"
                fi
        fi
                        sed "/${i}/d" $TRLOG > .trash.log2 && mv .trash.log2 $TRLOG
                ;;
                "n")
                        continue
                ;;
                *)
                        continue
                ;;
        esac
done

