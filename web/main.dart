library main;
import 'dart:json';
import 'dart:html';
import 'view.dart';
import 'model.dart';
import 'package:web_ui/web_ui.dart';


main() {
  generateGetMetrics();

}

void generateGetMetrics() {
  var metricunit = query("#metric-unit");
  var title = new Element.html("<h1>Get all the metrics!</h1>");
  var paragraph = new Element.html("<p>Some nice paragraph for our result.</p>");
  metricunit.children.add(title);
  metricunit.children.add(paragraph);
  
  InputElement metricInput = new Element.tag("input");
  metricInput.id = "metric-item";
  metricInput.placeholder = "Where art thou country?";
  metricunit.children.add(metricInput);

  
  ButtonElement searchButton = new Element.tag("button");
  searchButton.id = "btn-search";
  searchButton.text = "Search";
  searchButton.onClick.listen((e) => getMetricResponse(metricInput.value));
  metricunit.children.add(searchButton);

}

void getMetricResponse(Response){
  var l = new Locale('','','Europe',Response,'j','paris','');
  var m = new Metric('Maximum Upload Throughput','upload_throughput_max','Ms','Some nice RTT','NDT',0.0);
  var p = new Period(0,1,2012,0,0,0);
  l.getMetric(m,p);

}