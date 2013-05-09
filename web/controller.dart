part of moire;

class MetricValue {
  final double value;
  final String units;

  MetricValue(this.value, this.units);

  String toString() => "${value.toStringAsFixed(3)} $units";
}

/** Container for all logic for the application. */
class Controller {
  @observable
  DateTime startDate;

  @observable
  DateTime endDate;

  Ranking _ranking = null;
  String localeName;

  Locale get locale => kLocales[localeName];

  String get startMonth => startDate.month.toString();
  set startMonth(String value) {
    startDate = new DateTime.utc(startDate.year, int.parse(value));
  }

  String get endMonth  => endDate.month.toString();
  set endMonth(String value) {
    endDate = new DateTime.utc(endDate.year, int.parse(value));
  }

  String get startYear  => startDate.year.toString();
  set startYear(String value) {
    startDate = new DateTime.utc(int.parse(value),startDate.month);
  }

  String get endYear  => endDate.year.toString();
  set endYear(String value) {
    endDate = new DateTime.utc(int.parse(value),endDate.month);
  }

  /** Return the value of a metric of [type] for a given [date]. */
  Future<MetricValue> getMetricValue(String type, DateTime date) {
    Completer completer = new Completer();
    _loadData("metric/${type}?year=${date.year}&month=${date.month}&"
              "locale=${locale.toAPIString()}").then((Map m) {
        if (!m.containsKey("value"))
          completer.completeError("Unable to get metric");
        else
          completer.complete(new MetricValue(m["value"], m["units"]));
    })
    .catchError((e) => completer.completeError("API Error: $e"));
    return completer.future;
  }

  Future<Map<DateTime, MetricValue>> getMetricsForPeriod(String type) {
    Completer completer = new Completer();
    print(startDate);
    print(endDate);
    _loadData("metric/${type}?year=${startDate.year}&month=${startDate.month}&"
              "endyear=${endDate.year}&endmonth=${endDate.month}&"
              "locale=${locale.toAPIString()}").then((Map<String, Map> m) {
        Map<DateTime, MetricValue> results = new Map<DateTime, MetricValue>();
        m.forEach((String date_str, Map metric) {
          if (!metric.containsKey("value"))
            completer.completeError("Unable to get metric");
          else {
            List<String> dateParts = date_str.split("-");
            DateTime date = new DateTime.utc(int.parse(dateParts[0]),
                                             int.parse(dateParts[1]));
            MetricValue metricValue = new MetricValue(metric["value"],
                                                      metric["units"]);
            results[date] = metricValue;
          }
        });
        completer.complete(results);
    })
    .catchError((e) => completer.completeError("API Error: $e"));
    return completer.future;
  }

  Future<List<MetricValue>> getMetricValuesForPeriod(String type) {
    Completer completer = new Completer();
    getMetricsForPeriod(type).then((Map<DateTime, MetricValue> results) {
      List<MetricValue> values = new List<MetricValue>();
      List<DateTime> keys = results.keys.toList();
      keys.sort((DateTime a, DateTime b) => a.compareTo(b));
      keys.forEach((k) => values.add(results[k]));
      completer.complete(values);
    });
    return completer.future;
  }

  Future<int> getRank(String metric_type) {
    Completer completer = new Completer();
    if (_ranking != null && _ranking.isUpToDate(this, metric_type)) {
      completer.complete(_ranking.getRankForLocale(localeName));
    } else {
      // TODO: don't start this if one is in flight.
      Ranking.create(this, metric_type).then((r) {
          _ranking = r;
          completer.complete(r.getRankForLocale(localeName));
      });
    }
    return completer.future;
  }

  Future<Map> _loadData(String api_call) {
    Completer completer = new Completer();
    HttpRequest.getString("$kMetricsAPIUrl/" + api_call).then((response) {
      Map result = parse(response);
      if (result.containsKey("error")) {
        completer.completeError(result["error"]);
      } else {
        // print('Your metric ${result["units"]} is ${result["value"]}');
        completer.complete(result);
      }
    })
    .catchError((e) => completer.completeError("HTTP Error: $e"));
    return completer.future;
    //TODO: return an object instead of a map
  }
}

