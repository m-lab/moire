part of moire_test;

void testMetric() {
  group('Metric operations', () {
    test("kMetrics", () {
      Metric m = kMetrics["min_rtt"];
      expect(m.name, "Minimum RTT");
      expect(m.test, "NDT");
    });
    test("getMetric", () {
      Controller controller = new Controller();
      controller.localeName = 'london';
      controller.getMetricValue("upload_throughput_max", new DateTime.utc(2012, 1))
          .then(expectAsync1((MetricValue v) {
              expect(v.value, 0.569035);
              expect(v.units, "Mbps");
          }))
          .catchError(expectAsync1((String e) => expect(false, 'Should not be reached: $e'), count:0));
    });

    test("getMetricValuesForPeriod", () {
      Controller controller = new Controller();
      controller.localeName = 'london';
      controller.startDate = new DateTime.utc(2011, 11);
      controller.endDate = new DateTime.utc(2012, 4);
      controller.getMetricValuesForPeriod("upload_throughput_max")
          .then(expectAsync1((List<MetricValue> results) {
              expect(results.map((e) => e.value).toList(),
                     [0.561083, 0.563226, 0.569035, 0.581648, 0.590309, 0.588962]);
          }))
          .catchError(expectAsync1((String e) => expect(false, "Should not be reached: $e"), count:0));
    });

    test("getMetricsForPeriod", () {
      Controller controller = new Controller();
      controller.localeName = 'london';
      controller.startDate = new DateTime.utc(2011, 11);
      controller.endDate = new DateTime.utc(2012, 4);
      controller.getMetricsForPeriod("upload_throughput_max")
          .then(expectAsync1((Map<DateTime, MetricValue> results) {
              expect(results.values.map((e) => e.value).toList(),
                     unorderedEquals(
                         [0.561083, 0.563226, 0.569035, 0.581648, 0.590309, 0.588962]));
              expect(results.keys, unorderedEquals(
                  [new DateTime.utc(2011,11),
                   new DateTime.utc(2011,12),
                   new DateTime.utc(2012,1),
                   new DateTime.utc(2012,2),
                   new DateTime.utc(2012,3),
                   new DateTime.utc(2012,4)]));
          }))
          .catchError(expectAsync1((String e) => expect(false, "Should not be reached: $e"), count:0));
    });
  });
}
