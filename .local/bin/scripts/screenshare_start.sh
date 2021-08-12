#!/bin/sh
pkill -9 xdg-desktop
/usr/libexec/xdg-desktop-portal &
/usr/libexec/xdg-desktop-portal-wlr &
notify-send -t 3000 --icon=video-television "Screensharing started"
