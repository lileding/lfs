#!/bin/bash
#
set -o nounset
set -o errexit

export LC_ALL=POSIX
export LFS_TGT=x86_64-lfs-linux-gnu
export CONFIG_SITE=$LFS/usr/share/config.site
export PATH=$LFS/tools/bin:/usr/bin:/bin
export DISTDIR=`realpath sources`
export WORKDIR=/tmp

#./pkg.sh cross-tools/baselayout.pkg

#./pkg.sh cross-tools/binutils.pkg
#./pkg.sh cross-tools/gcc.pkg
#./pkg.sh cross-tools/linux.pkg
#./pkg.sh cross-tools/glibc.pkg
#./pkg.sh cross-tools/libstdc++.pkg

./pkg.sh cross-tools/m4.pkg
./pkg.sh cross-tools/ncurses.pkg
./pkg.sh cross-tools/bash.pkg
./pkg.sh cross-tools/coreutils.pkg
./pkg.sh cross-tools/diffutils.pkg
./pkg.sh cross-tools/file.pkg
./pkg.sh cross-tools/findutils.pkg
./pkg.sh cross-tools/gawk.pkg
./pkg.sh cross-tools/grep.pkg
./pkg.sh cross-tools/gzip.pkg
./pkg.sh cross-tools/make.pkg
./pkg.sh cross-tools/patch.pkg
./pkg.sh cross-tools/sed.pkg
./pkg.sh cross-tools/tar.pkg
./pkg.sh cross-tools/xz.pkg
./pkg.sh cross-tools/binutils-2.pkg
./pkg.sh cross-tools/gcc-2.pkg
