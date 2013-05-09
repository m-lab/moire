import 'package:web_ui/web_ui.dart';
import 'package:web_ui/watcher.dart' as watchers;
import 'dart:html';
import '../moire.dart';

class DateDiv extends WebComponent {
  View view;

  @observable String get startMonth => view.startMonth;
  @observable String get startYear => view.startYear;
  @observable String get endMonth => view.endMonth;
  @observable String get endYear => view.endYear;

  set startMonth(String month) => view.startMonth = month;
  set startYear(String year) => view.startYear = year;
  set endMonth(String month) => view.endMonth = month;
  set endYear(String year) => view.endYear = year;
}
