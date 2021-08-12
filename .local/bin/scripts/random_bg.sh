#!/bin/sh
UID=`id -u`
SWAYSOCK=`/usr/bin/fd -1 -g "sway-ipc.*.sock" /run/user/$UID/`
/usr/bin/swaymsg "output * bg `/bin/fd -t f . $(/usr/bin/xdg-user-dir PICTURES)/Wallpapers | /usr/bin/shuf -n 1` fill"
