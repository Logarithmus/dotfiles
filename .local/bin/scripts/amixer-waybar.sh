#!/bin/sh
volume=`amixer -M sget Master | rg -o '([0-9]+)%' -r '$1'`
if [ $volume -gt 50 ]; then
	echo -n 🔊
elif [ $volume -gt 0 ]; then
	echo -n 🔉
else
	echo -n 🔈
fi
printf " %2d%%\n" $volume
