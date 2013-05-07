import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'package:web_ui/watcher.dart' as watchers;
import '../moire.dart';

class MetricDiv extends WebComponent {
  View view;
  String type;

  @observable
  String average;

  @observable
  String change;

  @observable
  String perQuarterChange;

  @observable
  String perYearChange;

  String get name => view.showMetricName(type);
  String get description => view.showMetricDefinition(type);
  String get rank => view.showRank();

  //TODO: when inserted happens, query dom, get on-changed, add eventhandler,
  // does the same thing as inserted.

  void inserted() {
    queryAll("input[name=dateInput]").forEach((InputElement e) {
      e.onChange.listen((Event e) => _updateAsyncMetricData());
    });
    _updateAsyncMetricData();
  }

  void _updateAsyncMetricData() {
    // TODO: Currently this is going to make two API calls for the same metric
    // and the same period. We can do better.
    view.showMetricAverage(type).then((String s) => average = s);
    view.showMetricChange(type).then((String s) => change = s);
    // TODO: get change from last quarter and last year.
  }
}
