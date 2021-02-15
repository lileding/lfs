#!/bin/sh
#
set -o errexit

systemd-nspawn \
    --directory=$LFS \
    --bind=`realpath ./sources`:/var/lib/lfs/distfiles \
    --bind=`realpath ./system`:/var/lib/lfs/repo \
    --setenv=HOME=/root \
    --setenv=TERM="$TERM" \
    --setenv=PS1='(lfs chroot) \u:\w\$ ' \
    --setenv=PATH=/bin:/usr/bin:/sbin:/usr/sbin \
    --setenv=MAKEOPTS="$MAKEOPTS" \
    /usr/sbin/pkg.sh /var/lib/lfs/repo/system.pkg
