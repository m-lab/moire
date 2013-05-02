library moire_test;

import 'package:unittest/unittest.dart';
import 'package:unittest/interactive_html_config.dart';

import '../web/moire.dart';

part 'test_metric.dart';

void main() {
  useInteractiveHtmlConfiguration();

  testMetric();
}
