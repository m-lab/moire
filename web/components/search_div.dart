import 'package:web_ui/web_ui.dart';
import 'package:web_ui/watcher.dart' as watchers;
import 'dart:html';
import '../moire.dart';

class SearchDiv extends WebComponent {
  View view;
  
  @observable 
  String search = '';
  
  Map<String, Locale> locations = kLocales;
      
  List<String> get results {
    var lQuery = search.toLowerCase();
    var res = locations.keys.where((v) => v.toLowerCase().contains(lQuery));       
    return (res.length <= 3) ? res.toList()
        : (res.take(3).toList());
  }

  bool get noMatches => results.isEmpty;
  
  void setLocation() {
   assert(kLocales.containsKey(search.toLowerCase())); 
   view.controller.locale = kLocales[search.toLowerCase()];
   print('You are now at ${view.controller.locale}');
   watchers.dispatch();
  }
  //TODO: refresh locale after update of locale
  
}
