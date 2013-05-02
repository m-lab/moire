import 'moire.dart';
import 'urls.dart';
import 'package:route/client.dart';

main() {
  //TODO: move to tests
  var v = new View();
  var c = new Controller();
  var b = new Chart('Some Title','none','LineChart',200,200);
  var l = new Locale(0.0,0.0,'Europe','250','j','paris','');
  var m = new Metric('Maximum Upload Throughput','upload_throughput_max','Ms','Some nice RTT','NDT',0.0,'01-12-2012');
  var p = new Period('20120112','20120112');
  c.getMetric(l,m,p);
  v.generateMasthead();
  c.updateLocale(l,'GB','H9','London');
  p.updateStartDate('20130112');
  p.updateEndDate('20140112');
  print(p.startDate);
  print(p.endDate);
  b.drawGraph();
  List metrics = [180,18,23];
  c.getAverage(metrics);
  c.getChange(metrics);
  l.getParent();
  l.getChildren();

  //Handles url's
  var router = new Router()
      ..addHandler(root, v.showHome)
      ..addHandler(localeUrl, v.showExplore)
      ..listen();
}