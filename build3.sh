#!/bin/sh
#
set -o errexit

mkdir -pv $LFS/build
systemd-nspawn \
    --directory=$LFS \
    --bind=`realpath ./sources`:/var/lib/lfs/distfiles \
    --bind=`realpath ./system`:/var/lib/lfs/packages \
    --setenv=HOME=/root \
    --setenv=TERM="$TERM" \
    --setenv=PS1='(lfs chroot) \u:\w\$ ' \
    --setenv=PATH=/bin:/usr/bin:/sbin:/usr/sbin \
    --setenv=WORKDIR=/build \
    --setenv=MAKEOPTS="$MAKEOPTS" \
    /usr/sbin/pkg.sh /var/lib/lfs/packages/system.pkg
rmdir $LFS/build
