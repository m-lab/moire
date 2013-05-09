part of moire;

class ExploreView extends View {
  // Used by various components. Related to controller.locale but may be limited in scope.
  Locale selectedLocale;

  ExploreView(Controller controller)
      : super(controller) {
    selectedLocale = locale;
  }

  String get testCount => "lots and lots of";

  Future<String> showMetric(String metric_type) {
    Completer completer = new Completer();
    _controller.getMetricValue(metric_type, _controller.startDate)
        .then((content) {
            completer.complete(content.toString());
        })
        .catchError((e) => _addError(e));
    return completer.future;
  }

  Future<String> showMetricChange(String metric_type) {
    Completer completer = new Completer();
    _controller.getMetricValuesForPeriod(metric_type)
        .then((List<MetricValue> content) {
            completer.complete(getChange(content).toString());
        })
        .catchError((e) => _addError(e));
    return completer.future;
  }

  Future<String> showMetricAverage(String metric_type) {
    Completer completer = new Completer();
    _controller.getMetricValuesForPeriod(metric_type)
        .then((List<MetricValue> content) {
            completer.complete(getAverage(content).toString());
        })
        .catchError((e) => _addError(e));
    return completer.future;
  }

  // TODO: getter
  String showMetricName(String type) => kMetrics[type].name;
  String showMetricDefinition(String type) => kMetrics[type].description;

  Future<String> showRank(String metric_type) {
    Completer completer = new Completer();
    // TODO: pass locale (maybe view limited locale?)
    _controller.getRank(metric_type).then((int rank) =>
        completer.complete(rank.toString()));
    return completer.future;
  }
}
