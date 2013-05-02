library moire;

import 'dart:async';
import 'dart:json';
import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'package:js/js.dart' as js;

part 'view.dart';
part 'controller.dart';
part 'period.dart';
part 'metric.dart';
part 'locale.dart';

const String kMetricsAPIUrl = "http://mlab-metrics-api-server.appspot.com/api";
const List<String> kSupportedMetrics = ['min_rtt','upload_throughput_max','download_througput_max'];
