#!/bash/bash

if [[ $# > 1 ]]; then
        echo "Много аргументов"
        exit 69
fi
if [[ $# != 1 ]]; then
        echo "Мало аргументов"
        exit 69
fi

if [[ ! -f $1 ]]; then
        echo "Такого файла нет."
        exit 1
fi
dir=".trash"
if [[ ! -d $dir ]]
then
	mkdir .trash
fi

tr=".trash/"
ln "$1" $tr$(date +"%s")

echo $(readlink -f $1) $b  >> .trash.log
rm $1
