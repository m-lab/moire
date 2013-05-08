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
    // TODO: is this call necessary? can it be made from the constructor?
    _chart.drawGraph();
  }
}
