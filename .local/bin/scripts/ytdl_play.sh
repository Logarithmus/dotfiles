#!/bin/sh
case "$1" in
	video|music|podcast) ;;
	*) echo "Please specify media type (video, music, podcast)" && return 0 ;;
esac
notify-send -t 3000 --icon=podcast --urgency=low "Playing $1" "$2"

case "$1" in
	video|podcast) speed="1.5" ;;
	music)         speed="1.0" ;;
esac

mpv_cmd="mpv --speed=$speed \
	--ytdl-raw-options=config-location=${XDG_CONFIG_HOME}/yt-dlp/$1 $2"

case "$1" in
	video)                   $mpv_cmd ;;
	music|podcast) $TERMINAL $mpv_cmd ;;
esac
