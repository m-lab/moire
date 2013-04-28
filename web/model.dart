library model;
import 'dart:json';
import 'dart:html';

class App{
  //TODO: implement app model
}

class Metric{
  String name;
  String type;
  String unit;
  String description;
  String test;
  double value;
  
  Metric(this.name,this.type,this.unit,this.description,this.test,this.value);
  
  // Constructor for instanciating Metric using JSON
  Metric.fromJson(Map json){
    name = json['name'];
    type = json['type'];
    unit = json['unit'];
    description = json['description'];
    value = json['value'];
  }
  //TODO: implement metric functions
 
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

  num getMetric(Metric,Period){
    var type = Metric.type;
    var month = Period.startMonth;
    var year = Period.startYear;
    var location = "${this.country}_${this.region}_${this.city}";
    
    var url = 'http://mlab-metrics-api-server.appspot.com/api/metric/$type?year=$year&month=$month&locale=$location';
    // TODO: error checking
    var request = HttpRequest.getString(url).then(loadMetric);
  }
  
  num loadMetric(String response_text){
    print(response_text);
    Map response = parse(response_text);
    var units = response['units'];
    var metric = response['metric'];
    num value = response['value'];
    window.alert('your metric $metric in $units returned $value');
  }
 
}

class Period{
  var startDay;
  var startMonth;
  var startYear;
  var endDay;
  var endMonth;
  var endYear;
  
  Period(this.startDay, this.startMonth, this.startYear, this.endDay, this.endMonth, this.endYear);
  
}

class Events{
  //TODO: implement events
}

class ISP{
  //TODO: implement internet service provider
}
