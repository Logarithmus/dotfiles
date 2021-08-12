#!/bin/sh
case "$1" in
	video|music|podcast) ;;
	*) echo "Please specify media type (video, music, podcast)" && return 0 ;;
esac
notify-send -t 3000 --icon=podcast --urgency=low "Playing $1" $(wl-paste)
mpv_cmd="mpv --ytdl-raw-options=config-location=${XDG_CONFIG_HOME}/youtube-dl/$1 $(wl-paste)"
case "$1" in
	video) $mpv_cmd ;;
	music|podcast) $TERMINAL $mpv_cmd ;;
esac
