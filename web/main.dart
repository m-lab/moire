library main;
import 'dart:json';
import 'dart:html';
import 'view.dart';
import 'model.dart';
import 'package:web_ui/web_ui.dart';
import 'package:route/client.dart';
import 'package:js/js.dart' as js;


main() {
  //TODO: move to tests
  var v = new View();
  var b = new Chart('Some Title','none','LineChart',200,200);
  var c = new Controller();
  var l = new Locale('','','Europe','250','j','paris','');
  var m = new Metric('Maximum Upload Throughput','upload_throughput_max','Ms','Some nice RTT','NDT',0.0,'01-12-2012');
  var p = new Period('20120112','20120112');
  c.getMetric(l,m,p);
  v.generateGetMetrics();
  v.generateHomeStatic();
  c.updateLocale(l,'240','j','london');
  p.updateStartDate('20130112');
  p.updateEndDate('20140112');
  print(p.startDate);
  print(p.endDate);
  b.drawGraph();
  List metrics = [12,18,23];
  c.getAverage(metrics);
}
