library moire;

import 'dart:async';
import 'dart:json';
import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'package:js/js.dart' as js;


part 'view.dart';
part 'controller.dart';
part 'metric.dart';
part 'locale.dart';

final View view = new View();
final Controller controller = new Controller();

Locale location = new Locale(continent: 'Europe', country: 'GB', region: 'H9', city: 'London');

const String kMetricsAPIUrl = "http://mlab-metrics-api-server.appspot.com/api";

