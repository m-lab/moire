import 'moire.dart';
import 'urls.dart';
import 'package:route/client.dart';

main() {
  //TODO: move to tests
  controller.startDate = new DateTime.utc(2012, 02, 01);
  controller.endDate = new DateTime.now();
  
  print(location.fullLocation);
  //Handles url's
  //TODO: fix handlers
  //var router = new Router()
  //    ..addHandler(root, )
  //    ..addHandler(localeUrl, v.showExplore())
  //    ..listen();
}
