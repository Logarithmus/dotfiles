#!/bin/sh
/bin/fd -g $1 | parallel ffmpeg -i {} -c:a libopus -b:a 96k {.}.opus
