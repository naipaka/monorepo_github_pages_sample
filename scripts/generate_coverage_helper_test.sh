#!/bin/sh

dirs=`find ./packages -mindepth 1 -maxdepth 1`
for dir in $dirs; do
    package_name=`basename $dir`
    mkdir -p packages/$package_name/test
    file=packages/$package_name/test/coverage_helper_test.dart

    echo "// Helper file to make coverage work for all dart files" > $file
    echo "// ignore_for_file: unused_import, directives_ordering\n" >> $file
    echo "import 'package:flutter_test/flutter_test.dart';" >> $file

    # lib配下のテスト対象ファイルを抽出
    target_directory=packages/$package_name/lib
    find $target_directory \
    '!' -path '*generated*/*' \
    '!' -path '*gen*/*' \
    '!' -path '*src*/*' \
    '!' -name '*.g.dart' \
    '!' -name '*.part.dart' \
    '!' -name '*.freezed.dart' \
    '!' -name '*.arb' \
    '!' -name 'generated_plugin_registrant.dart' \
    -name '*.dart' \
    | cut -f 4- -d "/" \
    | awk -v package=$package_name '{printf "import '\''package:%s/%s'\'';\n", package,$1}' >> $file

    echo "\nvoid main() {\n  test('For coverage', () {\n    expect(1 + 1, 2);\n  });\n}" >> $file
done
