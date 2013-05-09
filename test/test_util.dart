part of moire_test;

void testUtil() {
  group('Util operations',(){
    test("getAverage", () {
      List<double> input = [28.0, 10.0, 16.0, 4.0];
      List<MetricValue> inputValues = input.map((e) => new MetricValue(e, "foo")).toList();
      MetricValue average = getAverage(inputValues);
      expect(average.value, 14.5);
      expect(average.units, "foo");
    });

    test("getChange", () {
      List<double> input = [28.0, 10.0, 16.0, 4.0];
      List<MetricValue> inputValues = input.map((e) => new MetricValue(e, "foo")).toList();
      MetricValue change = getChange(inputValues);
      expect(change.value, -600);
      expect(change.units, "foo");
    });
  });
}