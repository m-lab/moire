library moire;

import 'dart:async';
import 'dart:json';
import 'dart:html';
import 'package:js/js.dart' as js;
import 'package:web_ui/watcher.dart' as watchers;
import 'ranking.dart';

part 'view.dart';
part 'controller.dart';
part 'metric.dart';
part 'locale.dart';


final View view = new View();
final Controller controller = new Controller();

const String kMetricsAPIUrl = "http://mlab-metrics-api-server.appspot.com/api";

