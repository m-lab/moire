import 'package:web_ui/web_ui.dart';
import 'package:web_ui/watcher.dart' as watchers;
import 'dart:html';
import '../moire.dart';

// TODO: country

class BreadCrumbDiv extends WebComponent {
  View view;

  void showCountry() {
    view.selectedLocale = new Locale(country: view.locale.country);
    query("#bc-country").classes.add("active");
    query("#bc-region").classes.remove("active");
    query("#bc-city").classes.remove("active");
  }

  void showRegion() {
     view.selectedLocale = new Locale(country: view.locale.country,
                                      region: view.locale.region);
     query("#bc-country").classes.remove("active");
     query("#bc-region").classes.add("active");
     query("#bc-city").classes.remove("active");
  }

  void showCity() {
    view.selectedLocale = new Locale(country: view.locale.country,
                                     region: view.locale.region,
                                     city: view.locale.city);
    query("#bc-country").classes.remove("active");
    query("#bc-region").classes.remove("active");
    query("#bc-city").classes.add("active");
  }

  void inserted() {
    // TODO: listen to search and update.
  }
}