#!/bash/bash

if [[ $# > 1 ]]; then
        echo "Много аргументов"
        exit 404
fi
if [[ $# != 1 ]]; then
        echo "Мало аргументов"
        exit 404
fi

if [[ ! -f $1 ]]; then
        echo "Такого файла нет."
        exit 404
fi
dir=".trash"
if [[ ! -e $dir ]]
then
	mkdir .trash
fi

tr=".trash/"
b=$(find ".trash/" -type f -name "[1-9]" | sed -e 's,.trash/,,')
b=$(echo $b | awk '{print NF}')
#echo $b
if [ -z $b ]
then
	ln "/home/user/lab4/"$1 "/home/user/lab4/.trash/1"
else
	b=$(($b + 1))
	ln "/home/user/lab4/"$1 "/home/user/lab4/.trash/"$b
fi

echo $(readlink -f $1) $b  >> .trash.log
rm $1