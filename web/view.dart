part of moire;

class View {
  Controller _controller;

  // Used by various components. Related to controller.locale but may be limited in scope.
  Locale selectedLocale;

  View(this._controller) {
    selectedLocale = locale;
  }

  Locale get locale => _controller.locale;

  String showTestCount() => "lots and lots of";

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

  // TODO: getter/setter
  String showStartMonth() => _controller.startMonth;
  String showStartYear() => _controller.startYear;
  String showEndMonth() => _controller.endMonth;
  String showEndYear() => _controller.endYear;
  String setStartMonth(String startMonth) => _controller.startMonth = startMonth;
  String setEndMonth(String endMonth) => _controller.endMonth = endMonth;
  String setStartYear(String startYear) => _controller.startYear = startYear;
  String setEndYear(String endYear) => _controller.endYear = endYear;

  Future<String> showRank(String metric_type) {
    Completer completer = new Completer();
    // TODO: pass locale (maybe view limited locale?)
    _controller.getRank(metric_type).then((int rank) => completer.complete(rank.toString()));
    return completer.future;
  }

  void _addError(String error) => _addAlert(error, true);

  DivElement _addAlert(String alert, [bool isError = false]) {
    ButtonElement closeButton = new ButtonElement();
    closeButton.text = "x";
    closeButton.type = "button";
    closeButton.classes.add("close");
    closeButton.attributes["data-dismiss"] = "alert";

    SpanElement errorText = new SpanElement();
    errorText.text = alert;

    DivElement errorDiv = new DivElement();
    errorDiv.classes.add("alert");
    if (isError) errorDiv.classes.add("alert-error");
    errorDiv.children.add(closeButton);
    errorDiv.children.add(errorText);

    query("#alerts").children.add(errorDiv);
    return errorDiv;
  }
}
