import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'package:web_ui/watcher.dart' as watchers;
import '../moire.dart';

class OverviewDiv extends WebComponent {
  View view;

  @observable
  String downloadAverage;

  @observable
  String uploadAverage;

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
    view.showMetricAverage('download_throughput_max').then((String s) => downloadAverage = s);
    view.showMetricAverage('upload_throughput_max').then((String s) => uploadAverage = s);
    // TODO: get change from last quarter and last year.
  }
}
