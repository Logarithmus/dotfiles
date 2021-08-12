#!/bin/sh
count=`xbps-query -l 2> /dev/null | wc -l`
if [ "$count" -eq "$count" ]; then
	echo "$count"
else
	exit 1
fi
