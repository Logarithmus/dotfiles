#!/bin/bash
cd /opt/glibc_chroot
mount -t proc /proc proc/
mount -t sysfs /sys sys/
mount --rbind /dev dev/
mount --rbind /dev/pts dev/pts
mount --rbind /run run/
mount --rbind /home home/
env -i DISPLAY=$DISPLAY HOME=/home/artur TERM=$TERM chroot --userspec=artur:artur . /bin/bash -c 'cd /home/artur/.wine32/drive_c/Games/Medieval\ II\ Total\ War/ && WINEPREFIX=/home/artur/.wine32 wine medieval2.exe @mods/teutonic/configuration.cfg --features.mod=mods/teutonic'
#env -i TERM=$TERM chroot . /bin/bash -l
