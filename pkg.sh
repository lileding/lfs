#!/bin/bash
#
PKG=$1

umask 022

source $PKG

DISTDIR=${DISTDIR:-/var/lib/lfs/distfiles}
WORKDIR=${WORKDIR:-/var/lib/lfs/packages}

basedir="${WORKDIR}/${pkgname}-${pkgver}"
srcdir="${basedir}/src"
pkgdir="${basedir}/pkg"

do_prepare() {
    echo "Prepare $pkgname-$pkgver"
    mkdir -p ${srcdir} ${pkgdir}
    for src in ${source[@]}; do
        srcfile=`basename ${src}`
        if [[ "${noextract[@]}" =~ "${srcfile}" ]]; then
            cp ${DISTDIR}/${srcfile} ${srcdir}
            continue
        fi
        tar xf ${DISTDIR}/${srcfile} -C ${srcdir}
    done
}

do_clean() {
    echo "Clean $pkgname-$pkgver"
    rm -rf "$basedir"
}

do_build() {
    echo "Build $pkgname-$pkgver"
    ( build )
}

do_prepare
do_build
do_clean
