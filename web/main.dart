import 'moire.dart';
import 'urls.dart';

final Controller controller = new Controller();
final View view = new View(controller);

void main() {
  //TODO: move to tests
  controller.startDate = new DateTime.utc(2012, 02, 01);
  controller.endDate = new DateTime.utc(2012, 04, 01);
  controller.locale = new Locale(continent: 'Europe', country: '826',
      region: 'eng', city: 'london');


  //Handles url's
  //TODO: fix handlers
  //var router = new Router()
  //    ..addHandler(root, )
  //    ..addHandler(localeUrl, v.showExplore())
  //    ..listen();
}

