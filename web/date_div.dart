import 'package:web_ui/web_ui.dart';
import 'package:web_ui/watcher.dart' as watchers;
import 'dart:html';
import 'moire.dart';

class DateDiv extends WebComponent {
  View view;
  
  @observable
  String get startMonth => view.showStartMonth();
  @observable
  String get startYear => view.showStartYear();
  @observable
  String get endMonth => view.showEndMonth();
  @observable
  String get endYear => view.showEndYear();
  
  set startMonth(String month){
    view.setStartMonth(month);
  }
  
  set endMonth(String month){
    view.setEndMonth(month);
  }
  
  set endYear(String year){
    view.setEndYear(year);
  }
  
  set startYear(String year){
    view.setStartYear(year);
  }
}
