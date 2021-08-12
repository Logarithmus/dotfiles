#/bin/sh
rg -rh Exec /etc/xdg/autostart | while read -r line; do "${line:5}" &; done
rg -rh Exec ~/.config/autostart | while read -r line; do "${line:5}" &; done
