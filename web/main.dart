import 'moire.dart';
import 'urls.dart';
import 'package:web_ui/web_ui.dart';
import 'package:web_ui/watcher.dart' as watchers;
import 'dart:async';

main() {
  //TODO: move to tests
  controller.startDate = new DateTime.utc(2012, 02, 01);
  controller.endDate = new DateTime.now();
  controller.metric = new Metric('Maximum Upload Throughput', 'upload_throughput_max', 'Average download speed is the median speed that users achieve on their connection.','NDT');
  controller.locale = new Locale(continent: 'Europe', country: '826', region: 'eng', city: 'london');

  //Handles url's
  //TODO: fix handlers
  //var router = new Router()
  //    ..addHandler(root, )
  //    ..addHandler(localeUrl, v.showExplore())
  //    ..listen();

  String avgDownloadSpeed = '258';
}

String showMetric() {
  Future future = controller.getMetric(controller.startDate);
  future.then((content) {
    print(content);
  });
  return future.toString();
}

String showMetricChange() {
  Future future = controller.getMetricsForPeriod();
  future.then((content){
    controller.getChange(content);   
    });
  return future.toString();
}

String showMetricAverage() {
  String average = "<loading>";
  controller.getMetricsForPeriod().then((List<double> content) {
    average = controller.getAverage(content).toStringAsFixed(3);
    watchers.dispatch();
  });
  return average;
}

String showMetricName() => controller.metric.name;

String showMetricDefinition() => controller.metric.description;
