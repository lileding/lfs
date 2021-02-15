#!/bin/sh
#
set -o errexit

chown -R root:root $LFS
mkdir -pv $LFS/{dev,proc,sys,run,root,tmp}
mkdir -pv $LFS/var/lib/lfs/{distfiles,packages}
install -vm755 pkg.sh $LFS/usr/sbin

systemd-nspawn \
    --directory=$LFS \
    --bind=`realpath ./sources`:/var/lib/lfs/distfiles \
    --bind=`realpath ./temp-tools`:/var/lib/lfs/packages \
    --setenv=HOME=/root \
    --setenv=TERM="$TERM" \
    --setenv=PS1='(lfs chroot) \u:\w\$ ' \
    --setenv=PATH=/bin:/usr/bin:/sbin:/usr/sbin \
    --setenv=WORKDIR=/tmp \
    --setenv=MAKEOPTS="$MAKEOPTS" \
    /usr/sbin/pkg.sh /var/lib/lfs/packages/temp-tools.pkg

strip --strip-debug $LFS/usr/lib/*
strip --strip-unneeded $LFS/usr/{,s}bin/*
strip --strip-unneeded $LFS/tools/bin/*
