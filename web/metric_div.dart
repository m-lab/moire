import 'package:web_ui/web_ui.dart';
import 'moire.dart';

class MetricDiv extends WebComponent {
  View view;
  String type;
  
  String get name => view.showMetricName(type);
  String get description => view.showMetricDefinition(type);
  
  @observable
  String average;
  
  @observable
  String change;
  
  void inserted() {
    view.showMetric(type).then((String s) => average = s);
    view.showMetricChange(type).then((String s) => change = s);
  }
}
