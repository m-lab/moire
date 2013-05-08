part of moire;

class View {
  Controller controller;

  View(this.controller);

  String showTestCount() {
    return "lots and lots";
  }

  Future<String> showMetric(String metric_type) {
    Completer completer = new Completer();
    controller.getMetricValue(metric_type, controller.startDate)
        .then((content) {
            completer.complete(content.toString());
        });
    return completer.future;
  }

  Future<String> showMetricChange(String metric_type) {
    Completer completer = new Completer();
    controller.getMetricValuesForPeriod(metric_type)
        .then((List<MetricValue> content) {
            completer.complete(controller.getChange(content).toString());
        });
    return completer.future;
  }

  Future<String> showMetricAverage(String metric_type) {
    Completer completer = new Completer();
    controller.getMetricValuesForPeriod(metric_type)
        .then((List<MetricValue> content) {
            completer.complete(controller.getAverage(content).toString());
        })
        .catchError((e) => completer.completeError(e));
    return completer.future;
  }

  String showMetricName(String type) => kMetrics[type].name;
  String showMetricDefinition(String type) => kMetrics[type].description;

  String showStartMonth() => controller.startMonth;
  String showStartYear() => controller.startYear;
  String showEndMonth() => controller.endMonth;
  String showEndYear() => controller.endYear;
  String setStartMonth(String startMonth) => controller.startMonth = startMonth;
  String setEndMonth(String endMonth) => controller.endMonth = endMonth;
  String setStartYear(String startYear) => controller.startYear = startYear;
  String setEndYear(String endYear) => controller.endYear = endYear;

  String showRank() => controller.getRank().toString();
}
