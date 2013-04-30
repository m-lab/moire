library moire;
import 'dart:json';
import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'package:route/client.dart';
import 'package:js/js.dart' as js;
import 'urls.dart';
part 'view.dart';
part 'model.dart';

main() {
  //TODO: move to tests
  var v = new View();
  var b = new Chart('Some Title','none','LineChart',200,200);
  var c = new Controller();
  var l = new Locale('','','Europe','250','j','paris','');
  var m = new Metric('Maximum Upload Throughput','upload_throughput_max','Ms','Some nice RTT','NDT',0.0,'01-12-2012');
  var p = new Period('20120112','20120112');
  c.getMetric(l,m,p);
  v.generateMasthead();
  c.updateLocale(l,'240','j','london');
  p.updateStartDate('20130112');
  p.updateEndDate('20140112');
  print(p.startDate);
  print(p.endDate);
  b.drawGraph();
  List metrics = [28,18,23];
  c.getAverage(metrics);
  c.getChange(metrics);
  
  //Handles url's
  var router = new Router()
  ..addHandler(root, v.showHome)
  ..addHandler(localeUrl, v.showExplore)
  ..listen();
}



