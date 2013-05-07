part of moire_test;

Controller controller = new Controller();

void testMetric() {
  group('Metric operations', () {
    test("kMetrics", () {
      Metric m = kMetrics["min_rtt"];
      expect(m.name, "Minimum RTT");
      expect(m.test, "NDT");
    });
    test("getMetric", () {
      controller.locale = new Locale(continent: 'Europe', country: '826', region: 'eng', city: 'london');
      controller.getMetricValue("upload_throughput_max", new DateTime.utc(2012, 1))
          .then(expectAsync1((MetricValue v) {
              expect(v.value, 0.569035);
              expect(v.units, "Mbps");
          }))
          .catchError(expectAsync1((String e) => expect(false, 'Should not be reached: $e'), count:0));
    });

    test("getMetricValuesForPeriod", () {
      controller.locale = new Locale(continent: "Europe", country: "826", region: "eng", city: "london");
      controller.startDate = new DateTime.utc(2011, 11);
      controller.endDate = new DateTime.utc(2012, 4);
      controller.getMetricValuesForPeriod("upload_throughput_max")
          .then(expectAsync1((List<MetricValue> results) {
              expect(results.map((e) => e.value).toList(),
                     [0.561083, 0.563226, 0.569035, 0.581648, 0.590309, 0.588962]);
          }))
          .catchError(expectAsync1((String e) => expect(false, "Should not be reached: $e"), count:0));
    });
  });

  group('List operations',(){
    test("getAverage", () {
      List<double> input = [28.0, 10.0, 16.0, 4.0];
      List<MetricValue> inputValues = input.map((e) => new MetricValue(e, "foo")).toList();
      MetricValue average = controller.getAverage(inputValues);
      expect(average.value, 14.5);
      expect(average.units, "foo");
    });

    test("getChange", () {
      List<double> input = [28.0, 10.0, 16.0, 4.0];
      List<MetricValue> inputValues = input.map((e) => new MetricValue(e, "foo")).toList();
      MetricValue change = controller.getChange(inputValues);
      expect(change.value, -600);
      expect(change.units, "foo");
    });

  });
}
