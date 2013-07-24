import 'dart:io';
import 'package:web_ui/component_build.dart';

// Ref: http://www.dartlang.org/articles/dart-web-components/tools.html

const List<String> kPages = const<String> [
    'web/explore.html',
//    'web/index.html',
    'web/ranking.html',
//    'web/metric.html'
];

main() => build(new Options().arguments, kPages);
