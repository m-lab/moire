part of moire;

/** Container for all logic for the application. */
class Controller{
  DateTime startDate;
  DateTime endDate;
  Locale locale;
  
  String get startMonth => startDate.month.toString();
  set startMonth(String value) {
    startDate = new DateTime(startDate.year, int.parse(value));
  }
  
  String get endMonth  => endDate.month.toString();
  set endMonth(String value) {
    endDate = new DateTime(endDate.year, int.parse(value));
  }
  
 
  String get startYear  => startDate.year.toString();
  set startYear(String value) {
    startDate = new DateTime(int.parse(value),startDate.month);
  }
  
  String get endYear  => endDate.year.toString();
  set endYear(String value) {
    endDate = new DateTime(int.parse(value),endDate.month);
  }
  
  /** Return the value of a metric for a given [date]. */
  // TODO: return unit alongside value.
  Future<double> getMetric(String type, DateTime date) {
    Completer completer = new Completer();
    _loadData("metric/${type}?year=${date.year}&month=${date.month}&locale=${locale.toString()}").then((Map m) {
        if (!m.containsKey("value"))
          completer.completeError("Unable to get metric");
        else
          completer.complete(m["value"]);
    })
    .catchError((e) => completer.completeError("API Error: $e"));
    return completer.future;
  }

  Future<Map> _loadData(String api_call) {
    Completer completer = new Completer();
    HttpRequest.getString("$kMetricsAPIUrl/" + api_call).then((response) {
      Map result = parse(response);
      if (result.containsKey("error")) {
        completer.completeError(result["error"]);
      } else {
        print('Your metric ${result["units"]} is ${result["value"]}');
        completer.complete(result);
      }
    })
    .catchError((e) => completer.completeError("HTTP Error: $e"));
    return completer.future;
    //TODO: return an object instead of a map
  }


  /** Returns a list of metric values. */
  Future<List<double>> getMetricsForPeriod(String type) {
    Completer completer = new Completer();

    int month = startDate.month;
    int year = startDate.year;

    Map<DateTime, double> results = new Map<DateTime, double>();
    while(year < endDate.year || month <= endDate.month) {
      DateTime now = new DateTime(year, month);
      results[now] = null;
      print('getting metric for ${now.toString()}');
      getMetric(type, now).then((double v) {
        print('  got metric for ${now.toString()}');
        results[now] = v;
        if (!results.containsValue(null)) {
          List<double> values = new List<double>();
          List<DateTime> keys = results.keys.toList();
          keys.sort((DateTime a, DateTime b) => a.compareTo(b));
          keys.forEach((k) => values.add(results[k]));
          completer.complete(values);
        }
      });

      if (++month == 13) {
        ++year;
        month = 1;
      }
    }

    return completer.future;
  }

  /**
   * Returns the average of a list of metrics. A list of metrics
   * is used to compute aggregates over time.
   */
  double getAverage(List<num> l) {
    assert(l != null);
    if (l.isEmpty)
      return 0.0;
    double avg = l.reduce((value, element) => value + element) / l.length;
    print('Your average is ${avg}');
    return avg;
  }

  /**
   * Returns the percentage change of a list of metrics.A list of metrics
   * is used to compute aggregates over time.
   */

  double getChange(List<num> l) {
    assert(l != null);
    if (l.isEmpty)
      return 0.0;
    double change = ((l.last - l.first) / l.last)*100;
    print('Your change is ${change} or (${change.toStringAsFixed(1)} %)');
    return change;
  }
}

/**
 * Class to define web services.
 */
class Service{
  var url;
  Service(this.url);
}

/**
 * Class to define internet service providers.
 */
class ISP{
  //TODO: implement internet service provider
}
