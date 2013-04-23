library model;
import 'dart:html';
import 'dart:json';
import 'package:web_ui';

// TODO: use dart style: http://www.dartlang.org/articles/style-guide/

class App{
  //TODO: implement app model
}

class Metric{
  var name;
  var type;
  var unit;
  var description;
  num value;
  num sample;
  num month;
  num year;
  
  Metric(this.name,this.type,this.unit,this.description,this.value,this.sample,this.month,this.year);
  
  // Constructor for instanciating Metric using JSON
  Metric.fromJson(Map json){
    name = json['name'];
    type = json['type'];
    unit = json['unit'];
    description = json['description'];
    value = json['value'];
    sample = json['sample'];
    month = json['month'];
    year = json['year'];
  }
  //TODO: implement metric functions
  
  void getMetric(type,year,month){
    var location = '826_eng_london';
    var url = 'http://mlab-metrics-api-server.appspot.com/api/metric/$type?year=$year&month=$month&locale=$location';
  
    // TODO: error checking
    HttpRequest.getString(url).then(loadMetric);
  }

  void loadMetric(String response_text){
    Map response = JSON.parse(response_text);
    String units = response['units'];
    String metric = response['metric'];
    String value = response['value'];
    print('your metric $metric in $units returned $value');
  }

}

class Location{
  var latitude;
  var longtitude;
  
  Location(this.latitude,this.longtitude);
  
  Location.fromJson(Map json){
    longtitude = json['longtitude'];
    latitude = json['latitude'];
  }
  
  void nearestLocation(latitude, longtitude){
    //TODO: query for nearest location based on latitude longitude
  }
 
  // TODO: make these getters
  num getAverageDownloadThroughput(Location, Month){
    var throughput;
    //TODO: getter for average download throughput
  }
  
  num getAverageUploadThroughput(Location, Month){
    //TODO: getter for average upload throughput
  }
  
  num getSample(Location, Metric){
    //TODO: getter for sample size
  }
  
  num getRank(Location, Metric){
    //TODO: getter for sample size
  }
}

class Event{
  //TODO: implement events
}

class ISP{
  //TODO: implement internet service provider
}
