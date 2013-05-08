import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'package:web_ui/watcher.dart' as watchers;
import '../moire.dart';

class GraphDiv extends WebComponent {
  View view;
  String type;

  Chart _chart;

  void inserted() {
    // TODO: width/height should come from HTML, probably.
    _chart = new Chart(view, 'visualization', type, 'none', 300,200);
    _drawGraph();

    queryAll("input[name=dateInput]").forEach((InputElement e) {
      e.onChange.listen((Event e) => _drawGraph());
    });
  }

  void _drawGraph() => _chart.drawGraph();
}
