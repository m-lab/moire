import 'moire.dart';
import 'urls.dart';
import 'package:web_ui/web_ui.dart';
import 'dart:async';

main() {
  //TODO: move to tests
  controller.startDate = new DateTime.utc(2012, 02, 01);
  controller.endDate = new DateTime.now();
  // TODO: metric should not be a controller state variable as it can change through a page. It should be a parameter to each method call.
  // TODO: However there should be a list of metrics that can be chosen from, maybe a map keyed by metric name.
  controller.locale = new Locale(continent: 'Europe', country: '826', region: 'eng', city: 'london');

  //Handles url's
  //TODO: fix handlers
  //var router = new Router()
  //    ..addHandler(root, )
  //    ..addHandler(localeUrl, v.showExplore())
  //    ..listen();

  String avgDownloadSpeed = '258';
}
