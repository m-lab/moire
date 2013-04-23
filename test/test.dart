
// test for report

import 'dart:io';
import 'package:web_ui/testing/render_test.dart';
import 'package:unittest/unittest.dart';
import 'package:unittest/html_config.dart';
import 'package:unittest/vm_config.dart';

import '../web/model.dart';
import '../web/view.dart';

void main() {
  //Set up client side HTML configuration
  
  useHtmlConfiguration();
  
  group('Metrics', () {
    test("Metric constructor", (){
    var item = new Metric('Minimum RTT','rtt_min','msec','RoundtripTime',8,20000,7,2012);
    expect(item, isNotNull);
    });
  });
}