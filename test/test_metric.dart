part of moire_test;

void testMetric() {
  group('Metrics', () {
    test("Metric constructor", () {
      Metric item = new Metric('Minimum RTT', 'min_rtt', 'RoundtripTime', "NDT");
    });

    test("Get a metric", () {
      Controller c = new Controller();
      var l = new Locale(continent: 'Europe', country: '826', region: 'eng', city: 'london');
      var m = new Metric('Maximum Upload Throughput', 'upload_throughput_max', 'Some nice RTT','NDT');
      var p = new Period.fromStrings('20120112','20120112');

      c.getMetric(l, m, p)
          .then((double v) => expect(v, 0.569035))
          .catchError((String e) => expect(false, 'Should not be reached: $e'));
    });
  });
}
