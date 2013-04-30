part of moire;

class Controller{
  final List CurrentMetrics = ['min_rtt','upload_throughput_max','download_througput_max'];
  
  num getMetric(Location,Metric,Period){
    var type = Metric.type;
    var month = Period.startDate.month;
    var year = Period.startDate.year;
    //TODO: handle location hierarcy in parsing results. If statement to check if region and city =! null
    var location = "${Location.country}_${Location.region}_${Location.city}";
    
    
    var url = 'http://mlab-metrics-api-server.appspot.com/api/metric/$type?year=$year&month=$month&locale=$location';
    // TODO: error checking
    var request = HttpRequest.getString(url).then(loadMetric);
  }
  
  num loadMetric(String response_text){
    print(response_text);
    Map response = parse(response_text);
    var units = response['units'];
    var metric = response['metric'];
    double value = response['value'];
    return value;
    //TODO: return value to metric
    window.alert('your metric $metric in $units returned $value');
  }
  
  List getMetrics(Location,Period){
  //TODO: Based on Location and Period, iterate over months between startDate and endDate and add values to list
    List metrics;
  //  for(i=Period.startMonth.month; i<Period.endMonth.month; i++)
  //    metrics[i] = this.getMetric(Location, Metric, Period);
    
  }
  
  double getAverage(metrics){
    //TODO: error handling
    double avg = metrics.reduce((value, element) => value + element) / metrics.length; 
    print('your average is ${avg}');
    return avg;
  }
  
  void updateLocale(Locale, [country, region, city]){
    //TODO: error handling
    Locale.country = country;
    Locale.region = region;
    Locale.city = city;
  }
  
  void getNearest(){
    //Todo: get the nearest existing location of an input
  }
}

class Metric{
  String name;
  String type;
  String unit;
  String description;
  String test;
  double value;
  var date;
  
  Metric(this.name,this.type,this.unit,this.description,this.test,this.value,this.date);
 
}

class Service{
  var url;
  Service(this.url);
}

class Locale{
  var latitude;
  var longtitude;
  String continent;
  String country;
  String region;
  String city;
  String type;
  
  Locale(this.latitude,this.longtitude,this.continent, this.country,this.region, this.city, this.type);
 
}

class Period{
  DateTime startDate;
  DateTime endDate;
  
  Period(String start, String end) { // constructor with instance parameters
    this.startDate = DateTime.parse(start);
    this.endDate = DateTime.parse(end);
  }
 
  //Updates UTC formated string to DateTime object
  void updatePeriod(Period, [start, end]){
    Period.startDate = DateTime.parse(start);
    Period.endDate = DateTime.parse(end);
  }
  
  //Updates startDate for UTC formated string to DateTime object
  void updateStartDate(String StartDate){
    if(StartDate != ''){
      this.startDate = DateTime.parse(StartDate);
    } else {
      print('StartDate value must be greater than zero');
    }
  }
  
  //Updates endDate for UTC formated string to DateTime object
  void updateEndDate(String endDate){
    if(endDate != ''){
      this.endDate = DateTime.parse(endDate);
    } else {
      print('EndDate value must be greater than zero');
    }
  }
}

class ISP{
  //TODO: implement internet service provider
}
