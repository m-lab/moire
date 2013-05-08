part of moire;

class View {
  Controller controller;

  View(this.controller);

  String showTestCount() {
    return "lots and lots";
  }

  Future<String> showMetric(String metric_type) {
    Completer completer = new Completer();
    controller.getMetricValue(metric_type, controller.startDate)
        .then((content) {
            completer.complete(content.toString());
        });
    return completer.future;
  }

  Future<String> showMetricChange(String metric_type) {
    Completer completer = new Completer();
    controller.getMetricValuesForPeriod(metric_type)
        .then((List<MetricValue> content) {
            completer.complete(controller.getChange(content).toString());
        });
    return completer.future;
  }

  Future<String> showMetricAverage(String metric_type) {
    Completer completer = new Completer();
    controller.getMetricValuesForPeriod(metric_type)
        .then((List<MetricValue> content) {
            completer.complete(controller.getAverage(content).toString());
        })
        .catchError((e) => completer.completeError(e));
    return completer.future;
  }

  String showMetricName(String type) => kMetrics[type].name;
  String showMetricDefinition(String type) => kMetrics[type].description;

  String showStartMonth() => controller.startMonth;
  String showStartYear() => controller.startYear;
  String showEndMonth() => controller.endMonth;
  String showEndYear() => controller.endYear;
  String setStartMonth(String startMonth) => controller.startMonth = startMonth;
  String setEndMonth(String endMonth) => controller.endMonth = endMonth;
  String setStartYear(String startYear) => controller.startYear = startYear;
  String setEndYear(String endYear) => controller.endYear = endYear;

  String showRank() => controller.getRank().toString();
}
class Chart {
  String title;
  String metric_type;
  var legend;
  int width;
  int height;
    
  Chart(String title, String metric_type, var legend, int width, int height){
    this.title=title;
    this.metric_type=metric_type;
    this.legend=legend;
    this.width=width;
    this.height=height;
  }

  //Draws graph using the Vizualization API.
  void drawGraph() {
    js.context.google.load('visualization', '1', js.map({
        'packages': ['corechart'],
        'callback': new js.Callback.once(this.buildGraph)
    }));
  }

  //Builds graph using the Vizualization API.
  //TODO: check getter error in js.context.google, because it seems to work
  //TODO: pass data from other methods to build the graph.
  void buildGraph() {
    var gviz = js.context.google.visualization;

    // Create and populate the data table.
    controller.getMetricsForPeriod(metric_type)
      .then((Map<DateTime, double> results) {
        List<List> listData = new List<List>();

        results.forEach((k, v) {
          listData.add([k.toString(), v.toString()]);
        });

        var arrayData = js.array(listData);
        var tableData = gviz.arrayToDataTable(arrayData);

        // Sets options for chart.
        //TODO: subclasses have other options
        var options = js.map({
          'curveType': "function",
          'title': '${this.title}',
          'width': '${this.width}',
          'height': '${this.height}',
        });

        // Create and draw the visualization.
        var chart = new js.Proxy(gviz.LineChart, query('#visualization'));
        chart.draw(tableData, options);
    });
  }
}

