part of moire_test;

void testMetric() {
  group('metric ctor', () {
    test("Metric constructor", () {
      Metric item = new Metric('Minimum RTT', 'min_rtt', 'RoundtripTime', "NDT");
    });

    test("getMetric", () {
      Controller c = new Controller();
      c.locale = new Locale(continent: 'Europe', country: '826', region: 'eng', city: 'london');
      c.metric = new Metric('Maximum Upload Throughput', 'upload_throughput_max', 'Some nice RTT','NDT');

      c.getMetric(new DateTime.utc(2012, 1))
          .then((double v) => expect(v, 0.569035))
          .catchError((String e) => expect(false, 'Should not be reached: $e'));
    });

    test("getMetricsForPeriod", () {
      expect(false, "Not yet implemented");
    });
  });
}
