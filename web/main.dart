library main;
import 'dart:json';
import 'dart:html';
import 'model.dart';


/**
 * Learn about the Web UI package by visiting
 * http://www.dartlang.org/articles/dart-web-components/.
 */
void main() {
  var q = new Metric('Minimum RTT','rtt_min','msec','RoundtripTime',8,20000,7,2012);
  print(q);
}

