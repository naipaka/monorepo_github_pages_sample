#!/bin/sh

dirs=`find ./packages -mindepth 1 -maxdepth 1`

for dir in $dirs; do
    package_name=`basename $dir`
    (
        cd packages/$package_name && \
        genhtml coverage/lcov.info -o ../../site/packages/$package_name/coverage/html -p $(pwd)
    )
done