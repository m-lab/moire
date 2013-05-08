import 'package:web_ui/web_ui.dart';
import 'package:web_ui/watcher.dart' as watchers;
import 'dart:html';
import '../moire.dart';

class BreadCrumbDiv extends WebComponent {
  View view;

  void showCountry() {
    view.controller.locale =
        new Locale(country: view.controller.locale.country);
  }

  void showRegion() {
     view.controller.locale =
         new Locale(country: view.controller.locale.country,
                    region: view.controller.locale.region);
  }

  void showCity() {
    view.controller.locale =
        new Locale(country: view.controller.locale.country,
                   region: view.controller.locale.region,
                   city: view.controller.locale.city);
  }
  //TODO: change 'active' and coloring
  //TODO: refresh breadcrumb after update of locale
}