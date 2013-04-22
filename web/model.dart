library model;
import 'dart:html';
import 'dart:json';
import 'package:web_ui';

class App{
  //TODO: implement app model
}

@observable
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
  
  getMetric(type,year,month){
    var location = '826_eng_london';
    var url = 'http://mlab-metrics-api-server.appspot.com/api/metric/$type?year=$year&month=$month&locale=$location';
    var request = new HttpRequest();
    
    request.open('GET', url);
    request.on.loadMetric.add((e) => loadMetric(request));
    request.send();
  }

  loadMetric(HttpRequest request){
    if(request.status != 200){
      print('Whoops, ${request.status}');
      return;
    }
    Map response = JSON.parse(request.responseText);
    String units = response['units'];
    String metric = response['metric'];
    String value = response['value'];
    print('your metric $metric in $units returned $value');
  }

}

@observable
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

@observable
class Event{
  //TODO: implement events
}

@observable
class ISP{
  //TODO: implement internet service provider
}