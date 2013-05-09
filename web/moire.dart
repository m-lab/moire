library moire;

import 'dart:async';
import 'dart:json';
import 'dart:html';
import 'package:js/js.dart' as js;
import 'package:web_ui/watcher.dart' as watchers;
import 'package:web_ui/web_ui.dart';

part 'chart.dart';
part 'controller.dart';
part 'locale.dart';
part 'metric.dart';
part 'ranking.dart';
part 'util.dart';
part 'view.dart';

const String kMetricsAPIUrl = "http://mlab-metrics-api-server.appspot.com/api";
