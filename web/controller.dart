part of moire;

/**
 * An object that controls the application using the models and the view.
 * Contains a list of [SupportedMetrics] that can be used in the application.
 */


class Controller{
  final List SupportedMetrics = ['min_rtt','upload_throughput_max','download_througput_max'];
  
  Future<Map> getMetric(locale,metric,period){
    String type = metric.type;
    String location = locale.toString();
    print(location);
    var month = period.startDate.month;
    var year = period.startDate.year;
    String url = 'http://mlab-metrics-api-server.appspot.com/api/metric/$type?year=$year&month=$month&locale=$location';  
    
    Completer completer = new Completer();
    
    loadData(completer,url);
    
    return completer.future;
  }
  
  
  Completer loadData(Completer completer, String url) {
    HttpRequest.getString(url).then((response) {
      Map result = parse(response);
      if (result.containsKey("error")) {
        completer.completeError(result["error"]);
      } else {
        completer.complete(result);
      }
    })
    .catchError((e) {
        // Invoked when the future is completed with an error
       print('le shit hit le fan ${e}');
    });
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
  double getAverage(List l){
    if(l != null){
      double avg = l.reduce((value, element) => value + element) / l.length; 
      print('Your average is ${avg}');
      return avg;
    }
    else{
      print("Your list cannot be empty");
    }
  }

  /**
   * Returns the percentage change of a list of metrics.A list of metrics
   * is used to compute aggregates over time.
   */

  double getChange(List l){
    if(l != null){
    double change = ((l.last - l.first) / l.last)*100; 
    print('Your change is ${change.toStringAsFixed(1)} %');
    return change;
    }
    else{
      print("Your list cannot be empty");
    }
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
