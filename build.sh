#!/bin/bash
#
set -o nounset
set -o errexit

export LFS=/tmp/lfs
export MAKEOPTS=-j64

#mkdir -pv $LFS

#time /bin/bash build1.sh
#(cd $LFS; tar cJvpf $HOME/lfs-10.0-systemd-stage1-`date +%Y%m%d`.tar.xz .)

#time sudo -E /bin/bash build2.sh
(cd $LFS; sudo tar cJvpf $HOME/lfs-10.0-systemd-stage2-`date +%Y%m%d`.tar.xz .)

#sudo -E /bin/bash build3.sh
#(cd $LFS; sudo tar cJvpf $HOME/lfs-10.0-systemd-stage3-`date +%Y%m%d`.tar.xz .)
