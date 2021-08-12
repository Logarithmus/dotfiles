#!/bin/sh
xbacklight -fps 30 -perceived $1
xbacklight -perceived -get | tee $XDG_CONFIG_HOME/xbacklight/percentage
