library moire_test;

import 'package:unittest/unittest.dart';
import 'package:unittest/html_enhanced_config.dart';

import '../web/moire.dart';

part 'test_metric.dart';

void main() {
  useHtmlEnhancedConfiguration();

  testMetric();
}
