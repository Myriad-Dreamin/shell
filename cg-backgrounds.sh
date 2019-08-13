#!/bin/bash

if [ -z $1 ]; then
	echo "must input path! ( e.g. cg-backgrounds ./ )"
	exit 1
fi

if [ -z $2 ]; then
	interval=1h
else
	interval=$2
fi

counter=~/.backgrounds

if [ ! -d $counter ]; then
	touch $counter
fi

cont=`cat $counter`
let index=cont

backgrounds_path=`readlink -f $1`
lists=(`ls $backgrounds_path`)
accepted_suffixs=("jpg png")
backgrounds=()
let backgrounds_count=0

function is_legal_suffix() {
	for accepted_suffix in $accepted_suffixs; do
		if [ $1 == $accepted_suffix ]; then
			return 0
		fi
	done
	return 3
}

for ((i=0;i<${#lists[@]};i++)) do
	suffix=${lists[i]##*.}
	if is_legal_suffix $suffix; then
		let backgrounds_count=$backgrounds_count+1
		backgrounds[$backgrounds_count]=${lists[i]}
	fi
done


if [[ $backgrounds_count -eq 0 ]]; then
	echo "error: can't not find valid background pictrue in "$backgrounds_path 
	exit 1
fi


let index=(index%$backgrounds_count)+1
for i in $(seq $index $backgrounds_count); do
	echo $i > $counter
	gsettings set org.gnome.desktop.background picture-uri $backgrounds_path/${backgrounds[$i]}
	sleep $interval
done

while true; do
	for i in $(seq 1 $backgrounds_count); do
		echo $i > $counter
		gsettings set org.gnome.desktop.background picture-uri $backgrounds_path/${backgrounds[$i]}
		sleep $interval
	done
done
