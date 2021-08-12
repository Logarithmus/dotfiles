#!/bin/sh
amixer -M sset Master $1 | rg -o "([0-9]+)%" -r '$1'
alsactl -f $XDG_CONFIG_HOME/alsa/asound.state store
