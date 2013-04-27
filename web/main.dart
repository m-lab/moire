library main;
import 'dart:json';
import 'dart:html';
import 'view.dart';
import 'model.dart';

/**
 * Learn about the Web UI package by visiting
 * http://www.dartlang.org/articles/dart-web-components/.
 */
void main() {
  var p = new Metric('Upload Speed','upload_throughput_max','Mbps','Upload Throughput',8,20000,1,2012);
  p.getMetric(p,'250_j_paris');
}
