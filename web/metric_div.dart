import 'package:web_ui/web_ui.dart';
import 'package:web_ui/watcher.dart';
import 'moire.dart';

class MetricDiv extends WebComponent {
  View view;
  String type;
  String average;
  String change;
  String perQuarterChange;
  String perYearChange;

  String get name => view.showMetricName(type);
  String get description => view.showMetricDefinition(type);
  String get rank => view.showRank();
  
  //TODO: when inserted happens, query dom, get on-changed, add eventhandler, does the same thing as inserted. 
  
  void inserted() {
    view.showMetric(type).then((String s) => average = s);
    view.showMetricChange(type).then((String s) => change = s);
    // TODO: get change from last quarter and last year.
  }
}
