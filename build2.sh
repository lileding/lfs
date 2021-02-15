#!/bin/sh
#
set -o errexit

chown -R root:root $LFS
mkdir -pv $LFS/{dev,proc,sys,run}
mkdir -pv $LFS/var/lib/lfs/{distfiles,repo}
install -vm755 pkg.sh $LFS/usr/sbin

systemd-nspawn \
    --directory=$LFS \
    --bind=`realpath ./sources`:/var/lib/lfs/distfiles \
    --bind=`realpath ./temp-tools`:/var/lib/lfs/repo \
    --setenv=HOME=/root \
    --setenv=TERM="$TERM" \
    --setenv=PS1='(lfs chroot) \u:\w\$ ' \
    --setenv=PATH=/bin:/usr/bin:/sbin:/usr/sbin \
    --setenv=MAKEOPTS="$MAKEOPTS" \
    /usr/sbin/pkg.sh /var/lib/lfs/repo/temp-tools.pkg

strip --strip-debug $LFS/usr/lib/*
strip --strip-unneeded $LFS/usr/{,s}bin/*
strip --strip-unneeded $LFS/tools/bin/*
exit

mkdir -pv $LFS/{dev,proc,sys,run}
mount -v --bind /dev $LFS/dev
mount -v --bind /dev/pts $LFS/dev/pts
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys
mount -vt tmpfs tmpfs $LFS/run
if [ -h $LFS/dev/shm ]; then
    mkdir -pv $LFS/$(readlink $LFS/dev/shm)
fi
mkdir -pv $LFS/var/lib/lfs/{distfiles,repo}
install -vm755 pkg.sh $LFS/usr/sbin
mount -v --bind `realpath sources` $LFS/var/lib/lfs/distfiles
mount -v --bind `realpath temp-tools` $LFS/var/lib/lfs/repo

chroot "$LFS" /usr/bin/env -i   \
    HOME=/root                  \
    TERM="$TERM"                \
    PS1='(lfs chroot) \u:\w\$ ' \
    PATH=/bin:/usr/bin:/sbin:/usr/sbin \
    MAKEOPTS="$MAKEOPTS" \
    /usr/sbin/pkg.sh /var/lib/lfs/repo/temp-tools.pkg

umount $LFS/var/lib/lfs/{repo,distfiles}
umount $LFS/dev/pts
umount $LFS/dev
umount $LFS/{sys,proc,run}

strip --strip-debug $LFS/usr/lib/*
strip --strip-unneeded $LFS/usr/{,s}bin/*
strip --strip-unneeded $LFS/tools/bin/*
