#!/bin/bash
#
PKG=$1

umask 022

source $PKG

DISTDIR=${DISTDIR:-/var/lib/lfs/distfiles}
PACKDIR=${PACKDIR:-/var/lib/lfs/packages}
WORKDIR=${WORKDIR:-$PACKDIR}

basedir="${WORKDIR}/${pkgname}-${pkgver}"
srcdir="${basedir}/src"
pkgdir="${basedir}/pkg"

do_depends() {
    echo "Solve depends of $pkgname-$pkgver"
    for dep in ${depends[@]}; do
        pkg.sh "${PACKDIR}/${dep}.pkg"
    done
}

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

do_depends
do_prepare
do_build
do_clean
