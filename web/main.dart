import 'moire.dart';
import 'urls.dart';

final Controller controller = new Controller();
final ExploreView exploreView = new ExploreView(controller);
final RankingView rankingView = new RankingView(controller);
final MetricView metricView = new MetricView(controller);

void main() {
  // Start values for site.
  controller.startDate = new DateTime.utc(2012, 02, 01);
  controller.endDate = new DateTime.utc(2012, 04, 01);
  controller.localeName = 'london';

  //Handles url's
  //TODO: fix handlers
  //var router = new Router()
  //    ..addHandler(root, )
  //    ..addHandler(localeUrl, v.showExplore())
  //    ..listen();
}

