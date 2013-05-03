part of moire;

/** Container for all logic for the application. */
class Controller{
  DateTime startDate;
  DateTime endDate;
 
  
 
  /** Given a [locale], a [metric], and a [period], return a Map containing the value of the metric. */
  // TODO: create a getMetricForMonth method that does this and call it from a getMetricsForPeriod
  // method that iterates over a Duration/Period.
  Future<double> getMetric(Locale locale, Metric metric, Period period) {
    String type = metric.type;
    String location = locale.toString();
    print(location);
    var month = period.startDate.month;
    var year = period.startDate.year;

    Completer completer = new Completer();
    _loadData("metric/$type?year=$year&month=$month&locale=$location").then((Map m) {
        if (!m.containsKey("value"))
          completer.completeError("Unabled to get metric");
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

  
  /** Returns a list of metrics for a certain period. */
  Future<List<Map>> getMetricsForPeriod(Locale location, Metric metric) {
    Completer completer = new Completer();
    
    int month = startDate.month;
    int year = startDate.year;
    
    List getMetricFns = new List();
    
    while(month <= endDate.month && year <= endDate.year){
      getMetricFns.add(getMetric(location,metric,new DateTime.utc(year,month)));
      
      if (++month == 13) {
        ++year;
        month = 1;
      }
    }
    
    Future.wait(getMetricFns).then((List<Map> responses) => completer.complete(responses));

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
    print('Your change is ${change.toStringAsFixed(1)} %');
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
