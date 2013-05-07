part of moire;

class MetricValue {
  final double value;
  final String units;
  
  MetricValue(this.value, this.units);
  
  String toString() => "${value.toStringAsFixed(3)} $units";
}

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
  
  /** Return the value of a metric of [type] for a given [date]. */
  Future<MetricValue> getMetricValue(String type, DateTime date) {
    Completer completer = new Completer();
    _loadData("metric/${type}?year=${date.year}&month=${date.month}&locale=${locale.toString()}").then((Map m) {
        if (!m.containsKey("value"))
          completer.completeError("Unable to get metric");
        else
          completer.complete(new MetricValue(m["value"], m["units"]));
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
  Future<Map<DateTime, MetricValue>> getMetricsForPeriod(String type) {
    Completer completer = new Completer();

    int month = startDate.month;
    int year = startDate.year;

    Map<DateTime, MetricValue> results = new Map<DateTime, MetricValue>();
    while(year < endDate.year || month <= endDate.month) {
      DateTime now = new DateTime(year, month);
      results[now] = null;
      print('getting metric for ${now.toString()}');
      getMetricValue(type, now).then((MetricValue v) {
        print('  got metric for ${now.toString()}');
        results[now] = v;
        if (!results.containsValue(null)) {
          completer.complete(results);
        }
      });

      if (++month == 13) {
        ++year;
        month = 1;
      }
    }

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

  /**
   * Returns the average of a list of metrics. A list of metrics
   * is used to compute aggregates over time.
   */
  MetricValue getAverage(List<MetricValue> l) {
    assert(l != null);
    if (l.isEmpty)
      return null;
    assert(l.every((e) => e.units == l.first.units));
    double sum = 0.0;
    l.forEach((e) => sum += e.value);
    double avg = sum / l.length;
    print('Your average is ${avg}');
    return new MetricValue(avg, l.first.units);
  }

  /**
   * Returns the percentage change of a list of metrics.A list of metrics
   * is used to compute aggregates over time.
   */

  MetricValue getChange(List<MetricValue> l) {
    assert(l != null);
    if (l.isEmpty)
      return null;
    assert(l.every((e) => e.units == l.first.units));
    double change = ((l.last.value - l.first.value) / l.last.value) * 100;
    print('Your change is ${change} or (${change.toStringAsFixed(1)} %)');
    return new MetricValue(change, l.first.units);
  }
  
  int getRank() {
    return 4;
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
