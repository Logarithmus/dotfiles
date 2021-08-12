#!/bin/bash
cd /opt/glibc_chroot
mount -t proc /proc proc/
mount -t sysfs /sys sys/
mount --rbind /dev dev/
mount --rbind /dev/pts dev/pts
mount --rbind /run run/
mount --rbind /home home/
env -i DISPLAY=$DISPLAY HOME=/home/artur TERM=$TERM chroot --userspec=artur:artur . /bin/steam
