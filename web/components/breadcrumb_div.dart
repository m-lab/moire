import 'package:web_ui/web_ui.dart';
import 'package:web_ui/watcher.dart' as watchers;
import 'dart:html';
import '../moire.dart';

class BreadCrumbDiv extends WebComponent {
  View view;

  void showLocation(String level) {
    if(level == 'country') {
      view.controller.locale =
          new Locale(country: view.controller.locale.country);
    } else if(level == 'region') {
      view.controller.locale =
          new Locale(country: view.controller.locale.country,
                     region: view.controller.locale.region);
    }
    print(view.controller.locale.fullLocation);
    }
  //TODO: change 'active' and coloring
  //TODO: refresh breadcrumb after update of locale
    
}