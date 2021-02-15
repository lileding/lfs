#!/bin/bash
#
source system/system.pkg

for i in ${depends_todo[@]}; do
    echo "pkgname=$i" > system/${i}.pkg
    cat <<"EOF" >> system/${i}.pkg
pkgver=
source=("")

build() {
    cd "${srcdir}/${pkgname}-${pkgver}"
}
EOF
done
