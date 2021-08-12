#!/bin/sh
xbps-uunshare -b /proc:proc/ -b /sys:sys/ -b /dev:dev/ -b /dev/pts:dev/pts -b /run:run/ -b /home:home/ -- /opt/glibc_chroot /bin/sh
