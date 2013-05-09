part of moire_test;

void testRanking() {
  group('Ranking operations', () {
    // NOTE: Do not add more tests here as they are run in parallel and that does nasty things to the Ranking object.
    test("Ranking tests", () {
        Controller controller = new Controller();
        controller.localeName = 'london';
        controller.startDate = new DateTime.utc(2012, 1);
        controller.endDate = new DateTime.utc(2012, 3);
        Ranking.create(controller, 'download_throughput_max').then(expectAsync1((Ranking ranking) {
            MetricValue actual = ranking.getMetricValueForLocale('london');
            expect(actual.value, 4.67446);
            expect(actual.units, "Mbps");
            expect(ranking.rankedLocales,
                ['netherlands', 'amsterdam', 'london', 'california', 'spain', 'rome', 'san francisco']);
        }))
        /*.catchError(expectAsync1((String e) {
            expect(false, 'Should not be reached: $e');
        }, count:0));*/
        ;
    });
  });
}
