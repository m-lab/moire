import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'package:web_ui/watcher.dart' as watchers;
import '../moire.dart';

class OverviewDiv extends WebComponent {
  ExploreView view;

  @observable String downloadAverage;
  @observable String uploadAverage;

  //TODO: when inserted happens, query dom for onsearch/breadcrumb, get on-changed, add eventhandler,
  void inserted() {
    queryAll("input[name=dateInput]").forEach((InputElement e) {
      e.onChange.listen((Event e) => _updateAsyncMetricData());
    });
    _updateAsyncMetricData();
  }

  void _updateAsyncMetricData() {
    view.showMetricAverage('download_throughput_max').then((String s) =>
        downloadAverage = s);
    view.showMetricAverage('upload_throughput_max').then((String s) =>
        uploadAverage = s);
  }
}
