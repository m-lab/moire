import 'moire.dart';
import 'urls.dart';
import 'package:web_ui/web_ui.dart';
import 'dart:async';
import 'package:web_ui/watcher.dart';

final Controller controller = new Controller();
final View view = new View(controller);

main() {
  //TODO: move to tests
  controller.startDate = new DateTime.utc(2012, 02, 01);
  controller.endDate = new DateTime.utc(2012, 03, 01);
  controller.locale = new Locale(continent: '', country: '528',
                                 region: 'nh', city: 'amsterdam');

  //Handles url's
  //TODO: fix handlers
  //var router = new Router()
  //    ..addHandler(root, )
  //    ..addHandler(localeUrl, v.showExplore())
  //    ..listen();
}

