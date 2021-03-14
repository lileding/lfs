#!/bin/sh
#
set -o errexit

systemd-nspawn \
    --directory=$LFS \
    --resolv-conf=off \
    --bind=`realpath ./orion`:/var/lib/lfs/packages \
    --setenv=HOME=/root \
    --setenv=TERM="$TERM" \
    --setenv=PS1='(lfs chroot) \u:\w\$ ' \
    --setenv=PATH=/bin:/usr/bin:/sbin:/usr/sbin \
    --setenv=WORKDIR=/build \
    --setenv=MAKEOPTS="$MAKEOPTS" \
    /usr/sbin/pkg.sh /var/lib/lfs/packages/betelgeuse.pkg
