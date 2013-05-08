library moire;

import 'dart:async';
import 'dart:json';
import 'dart:html';
import 'package:js/js.dart' as js;
import 'package:web_ui/watcher.dart' as watchers;

part 'ranking.dart';
part 'chart.dart';
part 'view.dart';
part 'controller.dart';
part 'metric.dart';
part 'locale.dart';


const String kMetricsAPIUrl = "http://mlab-metrics-api-server.appspot.com/api";


