#!/bin/sh
for cue_file in *.cue; do break; done
for flac_file in *.flac; do break; done
[ -z "$cue_file" ] && echo "Missing cue file" && return 1
[ -z "$flac_file" ] && echo "Missing flac file" && return 2
tmp_dir="/tmp/shnsplit/`basename "$PWD"`"
mkdir -p "$tmp_dir"
shnsplit -f "$cue_file" -t "%n. %t" -o flac -d "$tmp_dir" "$flac_file"
cuetag.sh "$cue_file" "$tmp_dir"/*.flac
ls "$tmp_dir"/*.flac | parallel ffmpeg -i {} -c:a libopus -b:a 96k {.}.opus
mv "$tmp_dir"/*.opus "$PWD" && rm -r "$tmp_dir" && rm -r "$PWD"/*.flac
