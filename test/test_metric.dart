part of moire_test;

void testMetric() {
  group('Metric operations', () {
    test("Metric constructor", () {
      Metric item = new Metric('Minimum RTT', 'min_rtt', 'RoundtripTime', "NDT");
      expect(item, isNotNull);
    });

    test("getMetric", () {
      controller.locale = new Locale(continent: 'Europe', country: '826', region: 'eng', city: 'london');
      controller.getMetric("upload_throughput_max", new DateTime.utc(2012, 1))
          .then(expectAsync1((double v) => expect(v, 0.569035)))
          .catchError(expectAsync1((String e) => expect(false, 'Should not be reached: $e'), count:0));
    });

    test("getMetricsForPeriod", () {
      controller.locale = new Locale(continent: "Europe", country: "826", region: "eng", city: "london");
      controller.startDate = new DateTime.utc(2011, 11);
      controller.endDate = new DateTime.utc(2012, 4);
      controller.getMetricsForPeriod("upload_throughput_max")
          .then(expectAsync1((List<double> results) {
              expect(results, [0.561083, 0.563226, 0.569035, 0.581648, 0.590309, 0.588962]);
          }))
          .catchError(expectAsync1((String e) => expect(false, "Should not be reached: $e"), count:0));
    });
  });

  group('List operations',(){
    test("getAverage", () {
      expect(controller.getAverage([28,10,16,4]), equals(14.5));
    });

    test("getChange", () {
      expect(controller.getChange([28,10,16,4]), equals(-600.0));
    });

  });
}
