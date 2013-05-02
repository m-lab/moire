library moire;

import 'dart:json';
import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'package:route/client.dart';
import 'package:js/js.dart' as js;
import 'urls.dart';
import 'dart:async';

part 'view.dart';
part 'controller.dart';
part 'period.dart';
part 'metric.dart';
part 'locale.dart';

main() {
  //TODO: move to tests
  var v = new View();
  var c = new Controller();
//  var b = new Chart('Some Title','none','LineChart',200,200);
  var l = new Locale(0.0, 0.0, 'Europe', 'GB', 'foo', 'London');
  var m = new Metric('Maximum Upload Throughput','upload_throughput_max','Ms','Some nice RTT','NDT',0.0,'01-12-2012');
  var p = new Period('20120112','20120112');
  c.getMetric(l,m,p).catchError((e) {
    print("getMetric ERROR: $e");
  });
  v.generateMasthead();
  p.updateStartDate('20130112');
  p.updateEndDate('20140112');
  print(p.startDate);
  print(p.endDate);
//  b.drawGraph();
  List metrics = [180,18,23];
  c.getAverage(metrics);
  c.getChange(metrics);
  l.getParent().catchError((e) {
    print("getParent ERROR: $e");
  });
  l.getChildren().catchError((e) {
    print("getChildren ERROR: $e");
  });

  
  //Handles url's
  var router = new Router()
      ..addHandler(root, v.showHome)
      ..addHandler(localeUrl, v.showExplore)
      ..listen();
}



