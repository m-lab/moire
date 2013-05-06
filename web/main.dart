import 'moire.dart';
import 'urls.dart';
import 'package:web_ui/web_ui.dart';
import 'package:web_ui/watcher.dart' as watchers;
import 'dart:async';

main() {
  //TODO: move to tests
  controller.startDate = new DateTime.utc(2012, 02, 01);
  controller.endDate = new DateTime.now();
  // TODO: metric should not be a controller state variable as it can change through a page. It should be a parameter to each method call.
  // TODO: However there should be a list of metrics that can be chosen from, maybe a map keyed by metric name.
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

String showTestCount() {
  return "lots and lots";
}

String showMetric(String metric_type) {
  String metricStr = "<loading>";
  controller.metric = new Metric('Metric name', metric_type, 'Metric description', 'Tool');
  controller.getMetric(controller.startDate).then((content) {
    metricStr = content.toString();
    watchers.dispatch();
  });
  return metricStr;
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
