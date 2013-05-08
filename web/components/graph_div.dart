import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'package:web_ui/watcher.dart' as watchers;
import '../moire.dart';

class GraphDiv extends WebComponent {
  View view;  
  String type;
  
  List values;
  

  Chart chart = new Chart('Download Throughput','download_throughput_max','none',300,200);
  
  void buildChart(){
    //TODO: get it to actually build
    //chart.drawGraph();
    //chart.buildGraph();
  }
}
