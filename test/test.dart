
// test for report

import 'dart:io';
import 'package:web_ui/testing/render_test.dart';
import 'package:unittest/unittest.dart';
import 'package:unittest/html_config.dart';

import '../web/moire.dart';

void main() {
  //Set up client side HTML configuration
  useHtmlConfiguration();

  group('Metrics', () {
    test("Metric constructor", () {
      Metric item = new Metric('Minimum RTT','rtt_min','msec','RoundtripTime',8,20000,7,2012);
      expect(item, isNotNull);
    });

    test("Get a metric", () {
      Controller c = new Controller();
      var l = new Locale('Europe', 'GB', 'H9', 'London');
      var m = new Metric('Maximum Upload Throughput','upload_throughput_max','Ms','Some nice RTT','NDT',0.0,'01-12-2012');
      var p = new Period('20120112','20120112');
      c.getMetric(l,m,p).then((Map m) {
        expect(m["value"], 0.612599);
      })
      .catchError((e) {
        print("getMetric ERROR: $e");
        assert(false);
      });
    });
  });
}
