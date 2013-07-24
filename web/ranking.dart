part of moire;

// TODO: BUG: Uncaught Error: Bad state: Future already completed
// Stack Trace:
// #0      _CompleterImpl.completeError (dart:async/future_impl.dart:14:22)
// #1      Ranking._buildRankingForMetric.<anonymous closure>.<anonymous closure> (http://127.0.0.1:3030/home/dominich/git/moire/web/ranking.dart:76:36)
// #2      _CatchErrorFuture._sendError (dart:async/future_impl.dart:317:24)
// #3      _FutureImpl._setError (dart:async/future_impl.dart:192:26)
// #4      _ThenFuture._sendValue (dart:async/future_impl.dart:282:16)
// #5      _FutureImpl._setValue (dart:async/future_impl.dart:176:26)
// #6      _CompleterImpl.complete (dart:async/future_impl.dart:11:21)
// #7      Controller._loadData.<anonymous closure> (http://127.0.0.1:3030/home/dominich/git/moire/web/out/controller.dart:143:27)
// #8      _ThenFuture._sendValue (dart:async/future_impl.dart:279:24)
// #9      _FutureImpl._setValue (dart:async/future_impl.dart:176:26)
// #10     _FutureImpl._setOrChainValue (dart:async/future_impl.dart:253:16)
// #11     _ThenFuture._sendValue (dart:async/future_impl.dart:285:21)
// #12     _FutureImpl._setValue (dart:async/future_impl.dart:176:26)
// #13     _CompleterImpl.complete (dart:async/future_impl.dart:11:21)
// #14     HttpRequest.request.<anonymous closure> (file:///mnt/data/b/build/slave/dartium-lucid32-full-trunk/build/src/out/Release/gen/webkit/bindings/dart/dart/html/HttpRequest.dart:26:27)
//
// Exception: Bad state: Future already completed

class Ranking {
  Controller _controller;

  // These represent the state that was used for the last calculation.
  String _metricType;
  DateTime _startDate;
  DateTime _endDate;

  // Maps a locale -> MetricValue.
  Map<String, MetricValue> _rankingData = null;

  /** Ordered list of locales for the given [_metricType] over the period from
   *  [_startDate] to [_endDate].
   */
  List<String> _rankedLocales = null;

  static Future<Ranking> create(Controller controller, String metricType) {
    Completer completer = new Completer();

    Ranking ranking = new Ranking();
    ranking._controller = controller;
    ranking._metricType = metricType;
    ranking._startDate = controller.startDate;
    ranking._endDate = controller.endDate;
    ranking._rankingData = new Map<String, MetricValue>();

    ranking._buildRankingForMetric(metricType).then((Map<String, MetricValue> m) {
      ranking._rankingData = m;
      ranking._rankedLocales = m.keys.toList();
      ranking._rankedLocales.sort((a, b) => Comparable.compare(m[b].value, m[a].value));
      completer.complete(ranking);
    })
    .catchError((e) {
        completer.completeError("Ranking Error: $e");
    });

    return completer.future;
  }

  bool isUpToDate(Controller controller, String metricType) =>
      controller == _controller &&
      metricType == _metricType &&
      controller.startDate == _controller.startDate &&
      controller.endDate == _controller.endDate;

  /** Builds a list of locale names given a metric type and two dates. */
  Future<Map<String, MetricValue>> _buildRankingForMetric(String metric_type) {
    Map<String, MetricValue> data = new Map<String, MetricValue>();

    Completer completer = new Completer();
    kLocales.keys.forEach((String locale) {
        data[locale] = null;
        // TODO: pass locale to controller methods.
        _controller._loadData("metric/${metric_type}?year=${_startDate.year}&"
                              "month=${_startDate.month}&"
                              "endyear=${_endDate.year}&"
                              "endmonth=${_endDate.month}&"
                              "locale=${kLocales[locale].toAPIString()}").then((Map<String, Map> m) {
            List<MetricValue> results = new List<MetricValue>();
            m.forEach((String date_str, Map metric) {
                if (!metric.containsKey("value")) {
                  completer.completeError("Unable to get metric");
                } else {
                  MetricValue metricValue = new MetricValue(metric["value"], metric["units"]);
                  results.add(metricValue);
                }
                data[locale] = getAverage(results);
                if (!data.containsValue(null)) {
                  completer.complete(data);
                }
            });
        })
        .catchError((e) {
            completer.completeError("API Error: $e");
        });
    });
    return completer.future;
  }

  List<String> get rankedLocales => _rankedLocales;

  MetricValue getMetricValueForLocale(String locale) => _rankingData[locale];
  String getLocaleRanked(int rank) => _rankedLocales[rank];
  int getRankForLocale(String locale) => _rankedLocales.indexOf(locale);
}
