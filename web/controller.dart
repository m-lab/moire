part of moire;

/** Container for all logic for the application. */
class Controller{
  /** Given a [locale], a [metric], and a [period], return a Map containing the value of the metric. */ 
  // TODO: create a getMetricForMonth method that does this and call it from a getMetricsForPeriod
  // method that iterates over a Duration/Period.
  Future<Map> getMetric(Locale locale, Metric metric, Period period) {
    String type = metric.type;
    String location = locale.toString();
    print(location);
    var month = period.startDate.month;
    var year = period.startDate.year;

    String url = "$kMetricsAPIUrl/metric/$type?year=$year&month=$month&locale=$location"; 
  
    Completer completer = new Completer();
    HttpRequest.getString(url).then((response) {
      print(response);
      Map result = parse(response);
      if (result.containsKey("error")) {
        completer.completeError(result["error"]);
      } else {
        if (result.containsKey("metric") && result.containsKey("value") && result.containsKey("units")) {
          print('Your location ${location} has a ${result["metric"]} of ${result["value"]} in ${result["units"]}');
          completer.complete(result);
        } else {
          completer.completeError("Malformed result: $result");
        }
      }
    })
    .catchError((e) {
        // Invoked when the future is completed with an error
       print('le shit hit le fan ${e}');
    });
    return completer.future;
  }
  
  /** Returns a list of metrics during a certain period. */
  List getMetrics(Locale location, Metric metric, Period period) {
  //TODO: Based on Location and Period, iterate over months between startDate and endDate and add values to list
    List metrics;
  //  for(i=Period.startMonth.month; i<Period.endMonth.month; i++)
  //    metrics[i] = this.getMetric(Location, Metric, Period);
    return metrics;
  }


  /**
   * Returns the average of a list of metrics. A list of metrics
   * is used to compute aggregates over time.
   */
  double getAverage(List<num> l) {
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
  //TODO: error handling for empty list, one element. 
  double getChange(List<double> l) {
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
