library main;
import 'dart:json';
import 'dart:html';
import 'view.dart';
import 'model.dart';
import 'package:web_ui/web_ui.dart';


main() {
  generateGetMetrics();
  generateHomeStatic();
}

void generateGetMetrics() {
  var metricunit = query("#metric-unit");
  var title = new Element.html("<h1>Get all the metrics!</h1>");
  var paragraph = new Element.html("<p>Find metrics for a country with an ugly id (for example 250)</p>");
  metricunit.children.add(title);
  metricunit.children.add(paragraph);
  
  InputElement metricInput = new Element.tag("input");
  metricInput.id = "metric-item";
  metricInput.placeholder = "What art thou country number?";
  metricInput.type = "text";
  metricunit.children.add(metricInput);

  
  ButtonElement searchButton = new Element.tag("button");
  searchButton.id = "btn-search";
  searchButton.text = "Search";
  searchButton.type = "button";
  searchButton.onClick.listen((e) => getMetricResponse(metricInput.value));
  metricunit.children.add(searchButton);

}

void generateHomeStatic(){
  var homestatic = query("#home-static");
  
  var download = new Element.html("""
  <div class="span4">
  <h2>Get the report</h2>
  <p>Every quarter the Open Technology Institute publishes the State of the Web report. In this report you can find the details from quarter to quarter. The report is published under creative commons so fee free to re-use is.</p>
  <p><a class="btn" href="#">PDF</a><a class="btn" href="#">ePub</a></p>
  </div>
  """);
  
  var countries = new Element.html("""
  <div class="span4">
  <h2>Countries we cover</h2>
  <p>The Open Internet report is based on over 3.3 billion measurements worldwide in 2013. We cover most of the world but for some countries we might not have enough data to draw conclusions. </p>
  <p><a class="btn" href="#">Learn more&raquo;</a></p>
  </div>
  """);
  
  var explenation = new Element.html("""
  <div class="span4">
  <h2>Fair &amp; Honest measurement</h2>
  <p>Donec sed odio dui. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa.</p>
  <p><a class="btn" href="#">Learn more</a></p>
  </div>
  """);
  
  homestatic.children.add(download);
  homestatic.children.add(countries);
  homestatic.children.add(explenation);
}

void getMetricResponse(Response){
  var l = new Locale('','','Europe',Response,'j','paris','');
  var m = new Metric('Maximum Upload Throughput','upload_throughput_max','Ms','Some nice RTT','NDT',0.0);
  var p = new Period(0,1,2012,0,0,0);
  l.getMetric(m,p);

}