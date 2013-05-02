part of moire;

/**
 * An object that controls the application using the models and the view.
 * Contains a list of [SupportedMetrics] that can be used in the application.
 */


class Controller{
  final List SupportedMetrics = ['min_rtt','upload_throughput_max','download_througput_max'];
  final Map MetricGraphs = {};

  /**
   * Requests the value of a metric given a location, period and metric.
   * Formats Location,Metric and Period into the proper HTTP GET URL, and performs a HTTP request.
   * Calls loadmetric for the response.
   */
  //TODO: handle location hierarcy in parsing results. If statement to check if region and city =! null
  num getMetric(Location,Metric,Period){
    var type = Metric.type;
    var month = Period.startDate.month;
    var year = Period.startDate.year;

    var location = "${Location.country}_${Location.region}_${Location.city}";
    var url = 'http://mlab-metrics-api-server.appspot.com/api/metric/$type?year=$year&month=$month&locale=$location';
    // TODO: error checking
    var request = HttpRequest.getString(url).then(loadMetric);
  }

  /**
   * Loads the metric using the HTTP response.
   * Grabs the JSON string and maps the respons to variables.
   * Returns the value.
   */
  num loadMetric(String response_text){
    print(response_text);
    Map response = parse(response_text);
    var units = response['units'];
    var metric = response['metric'];
    double value = response['value'];
    return value;
    //TODO: return value to metric, error handling
    window.alert('your metric $metric in $units returned $value');
  }

  /**
   * Returns a list of metrics during a certain period.
   */
  List getMetrics(Location, Metric, Period){
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
  double getAverage(List){
    //TODO: error handling for empty list
    double avg = List.reduce((value, element) => value + element) / List.length;
    print('Your average is ${avg}');
    return avg;
  }

  /**
   * Returns the percentage change of a list of metrics.A list of metrics
   * is used to compute aggregates over time.
   */
  //TODO: error handling for empty list, one element.
  double getChange(List){
    double change = ((List.last - List.first) / List.last)*100;
    print('Your change is ${change.toStringAsFixed(1)} %');
    return change;
  }

  /**
   * Updates the current locale to another locale.
   */
  //TODO: error handling, chose wether to spit or remove altogether.
  void updateLocale(Locale, [country, region, city]){
    Locale.country = country;
    Locale.region = region;
    Locale.city = city;
  }

  void getNearest(){
    //Todo: get the nearest existing location of an input
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
