library moire_test;

import 'package:unittest/unittest.dart';
import 'package:unittest/html_enhanced_config.dart';

import '../web/moire.dart';

part 'test_locale.dart';
part 'test_metric.dart';
part 'test_ranking.dart';
part 'test_util.dart';

void main() {
  useHtmlEnhancedConfiguration();

  testLocale();
  testMetric();
  testRanking();
  testUtil();
}
