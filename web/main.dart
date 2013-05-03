import 'moire.dart';
import 'urls.dart';
import 'package:route/client.dart';

main() {
  //TODO: move to tests
  var v = new View();
  var c = new Controller();
  var b = new Chart('Some Title','none','LineChart',200,200);
  var l = new Locale(continent: 'Europe', country: 'GB', region: 'H9', city: 'London');
  var n = new Locale(continent: 'Europe', country: '826', region: 'eng', city: 'london');
  var m = new Metric('Maximum Upload Throughput','upload_throughput_max','Ms','Some nice RTT','NDT',0.0,'01-12-2012');

  c.startDate = new DateTime.utc(2012,01,01);
  c.endDate = new DateTime.utc(2012,12,01);
  c.getMetric(l,m,c.startDate)
      .then((double v) => print("got metric $v"))
      .catchError((e) => print("getMetric ERROR: $e"));
  c.getMetric(n,m,c.startDate)
      .then((double v) => print("got metric $v"))
      .catchError((e) => print("getMetric ERROR: $e"));
  b.drawGraph();
  List metrics = [180,18,23];
  c.getAverage(metrics);
  c.getChange(metrics);
  l.getParent().catchError((e) {
    print("getParent ERROR: $e");
  });
  l.getChildren().catchError((e) {
    print("getChildren ERROR: $e");
  });
  v.generateMasthead();


  //Handles url's
  var router = new Router()
      ..addHandler(root, v.showHome)
      ..addHandler(localeUrl, v.showExplore)
      ..listen();
}
