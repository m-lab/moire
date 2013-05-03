import 'moire.dart';
import 'urls.dart';
import 'package:route/client.dart';

main() {
  //TODO: move to tests
  var v = new View();
  var b = new Chart('Some Title','none','LineChart',200,200);
  Locale l = new Locale(continent: 'Europe', country: 'GB', region: 'H9', city: 'London');
  b.drawGraph();
  v.generateMasthead();


  //Handles url's
  var router = new Router()
      ..addHandler(root, v.showHome)
      ..addHandler(localeUrl, v.showExplore)
      ..listen();
}
