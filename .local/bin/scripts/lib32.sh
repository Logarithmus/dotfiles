mkdir /r32
XBPS_ARCH=i686 xbps-install -S -r /r32 -R "$repo" base-system $packages
unlink /lib32
rm -rf /usr/lib32
ln -s /r32/lib /lib
ln -s /r32/lib /usr/lib32
