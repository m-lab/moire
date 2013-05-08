import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'package:web_ui/watcher.dart' as watchers;
import '../moire.dart';

class GraphDiv extends WebComponent {
  View view;
  String type;
  String div_id;

  Chart _chart;

  void inserted() {
    DivElement visDiv = query("#visualization");
    visDiv.id = div_id;
    _chart = new Chart(view, div_id, type, 'none',
                       visDiv.style.width, visDiv.style.height);
    _chart.drawGraph();

    queryAll("input[name=dateInput]").forEach((InputElement e) =>
        e.onChange.listen((Event e) => _chart.drawGraph()));
  }
}
